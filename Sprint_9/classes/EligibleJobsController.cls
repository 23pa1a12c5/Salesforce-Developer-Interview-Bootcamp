public with sharing class EligibleJobsController {

    @AuraEnabled(cacheable=true)
    public static List<Job__c> getEligibleJobs() {
        return [
            SELECT Id,
                   Name,
                   Company_Name__c,
                   Minimum_CGPA__c,
                   Eligible_Branch__c,
                   Application_Deadline__c
            FROM Job__c
            ORDER BY Application_Deadline__c ASC
        ];
    }

    @AuraEnabled
    public static String applyForJob(Id studentId, Id jobId) {
        return ApplicationService.applyForJob(studentId, jobId);
    }
}