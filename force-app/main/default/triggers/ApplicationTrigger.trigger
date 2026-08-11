trigger ApplicationTrigger on Application__c (after update) {

    List<Id> applicationIds = new List<Id>();

    for (Application__c newApp : Trigger.new) {

        Application__c oldApp = Trigger.oldMap.get(newApp.Id);

        if (
            newApp.Status__c == 'Selected' &&
            oldApp.Status__c != 'Selected'
        ) {
            applicationIds.add(newApp.Id);
        }
    }

    for (Id applicationId : applicationIds) {
        System.enqueueJob(
            new CandidateSyncQueueable(applicationId)
        );
    }
}
