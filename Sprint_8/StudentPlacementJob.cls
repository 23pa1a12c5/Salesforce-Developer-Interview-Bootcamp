public with sharing class StudentPlacementJob implements Queueable {
    private Id applicationId;
    public StudentPlacementJob(Id applicationId) {
        this.applicationId = applicationId;
    }
    public void execute(QueueableContext context) {
        Application__c app = [
            SELECT Id,
                   Student__c
            FROM Application__c
            WHERE Id = :applicationId
            LIMIT 1
        ];
        System.debug('Student Placement Job Executed');
        System.enqueueJob(
            new OfferPostProcessingJob(applicationId)
        );
    }
}