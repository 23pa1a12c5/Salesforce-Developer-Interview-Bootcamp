trigger ApplicationTrigger on Application__c (before insert, after update) {

    if (Trigger.isBefore && Trigger.isInsert) {

        ApplicationService.validateApplications(Trigger.new);
    }

    if (Trigger.isAfter && Trigger.isUpdate) {
        ApplicationService.processSelectedApplications(
            Trigger.new,
            Trigger.oldMap
        );
        for (Application__c app : Trigger.new) {
            Application__c oldApp = Trigger.oldMap.get(app.Id);

            if (oldApp.Status__c != 'Selected' &&
                app.Status__c == 'Selected') {
                ApplicationService.updatePlacementStatistics(app);
                System.enqueueJob(
                    new StudentPlacementJob(app.Id)
                );
            }
        }
    }
}