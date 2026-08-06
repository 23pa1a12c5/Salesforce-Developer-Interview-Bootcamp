trigger ApplicationTrigger on Application__c (before insert, after update) {

    if (Trigger.isBefore && Trigger.isInsert) {

        for (Application__c app : Trigger.new) {
            ApplicationService.validateApplication(app);
        }

    }

    if (Trigger.isAfter && Trigger.isUpdate) {

        for (Application__c app : Trigger.new) {

            Application__c oldApp = Trigger.oldMap.get(app.Id);

            if (oldApp.Status__c != 'Selected' &&
                app.Status__c == 'Selected') {

                ApplicationService.updatePlacementStatistics(app);

                NotificationService.sendNotification(app);
                AlumniService.updateAlumni(app);

            }
        }

    }
}