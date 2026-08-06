public with sharing class OfferPostProcessingJob implements Queueable {
    private Id applicationId;

    public OfferPostProcessingJob(Id applicationId) {
        this.applicationId = applicationId;
    }
    public void execute(QueueableContext context) {

        Application__c app = [
            SELECT Id,
                   Student__c,
                   Job__c,
                   Status__c
            FROM Application__c
            WHERE Id = :applicationId
            LIMIT 1
        ];

        System.debug('Queueable Job Executed for Application: ' + app.Id);       
        NotificationService.sendNotification(app);
        AlumniService.updateAlumni(app);
    }
}