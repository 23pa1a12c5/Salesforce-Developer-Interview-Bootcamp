public with sharing class CandidateSyncQueueable implements Queueable, Database.AllowsCallouts {

    private Id applicationId;

    public CandidateSyncQueueable(Id applicationId) {
        this.applicationId = applicationId;
    }

    public void execute(QueueableContext context) {

        Application__c application = [
            SELECT Id,
                   Name,
                   Student__r.Student_ID__c,
                   Student__r.Name,
                   Student__r.Email__c,
                   Student__r.Department__c,
                   Student__r.CGPA__c,
                   Job__r.Name,
                   Job__r.Company_Name__c,
                   Job__r.Eligible_Branch__c
            FROM Application__c
            WHERE Id = :applicationId
            LIMIT 1
        ];

        HttpRequest request = new HttpRequest();

        request.setEndpoint(
            'callout:External_Recruitment_API/candidates'
        );

        request.setMethod('POST');

        request.setHeader(
            'Content-Type',
            'application/json'
        );

        Map<String, Object> candidate = new Map<String, Object>{
            'applicationId' => application.Id,
            'studentId' => application.Student__r.Student_ID__c,
            'name' => application.Student__r.Name,
            'email' => application.Student__r.Email__c,
            'branch' => application.Student__r.Department__c,
            'cgpa' => application.Student__r.CGPA__c,
            'jobId' => application.Job__r.Name,
            'company' => application.Job__r.Company_Name__c,
            'role' => application.Job__r.Name
        };

        request.setBody(JSON.serialize(candidate));

        try {

            Http http = new Http();
            HttpResponse response = http.send(request);

            Integer statusCode = response.getStatusCode();
            String responseBody = response.getBody();

            System.debug('Candidate API Status: ' + statusCode);
            System.debug('Candidate API Response: ' + responseBody);

            // Record the attempt AFTER the callout
            application.Last_Integration_Attempt__c = System.now();

            if (statusCode == 200 || statusCode == 201) {

                application.Integration_Status__c = 'Sent';
                application.Integration_Error__c = null;

                // Read external candidate ID if returned
                try {
                    Map<String, Object> responseData =
                        (Map<String, Object>)
                        JSON.deserializeUntyped(responseBody);

                    if (responseData.containsKey('candidateId')) {
                        application.External_Candidate_Id__c =
                            String.valueOf(
                                responseData.get('candidateId')
                            );
                    }

                } catch (Exception parseException) {
                    System.debug(
                        'Response parsing warning: ' +
                        parseException.getMessage()
                    );
                }

            } else if (statusCode == 400) {

                application.Integration_Status__c = 'Failed';
                application.Integration_Error__c =
                    'Bad Request: ' + responseBody;

            } else if (statusCode == 401) {

                application.Integration_Status__c = 'Failed';
                application.Integration_Error__c =
                    'Authentication Failure: ' + responseBody;

            } else if (statusCode == 403) {

                application.Integration_Status__c = 'Failed';
                application.Integration_Error__c =
                    'Forbidden: ' + responseBody;

            } else if (statusCode >= 500) {

                application.Integration_Status__c = 'Retry Required';
                application.Integration_Error__c =
                    'Server Error: ' + responseBody;

            } else {

                application.Integration_Status__c = 'Failed';
                application.Integration_Error__c =
                    'Unexpected Response (' +
                    statusCode +
                    '): ' +
                    responseBody;
            }

            update application;

        } catch (Exception e) {

            // No DML occurred before the callout,
            // so we can safely update after the callout fails.

            application.Integration_Status__c = 'Retry Required';
            application.Last_Integration_Attempt__c = System.now();
            application.Integration_Error__c = e.getMessage();

            update application;

            System.debug(
                'Candidate sync failed: ' +
                e.getMessage()
            );
        }
    }
}