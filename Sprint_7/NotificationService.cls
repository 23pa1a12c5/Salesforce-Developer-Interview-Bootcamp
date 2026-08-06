public with sharing class NotificationService {

    public static void sendNotification(Application__c app) {

        System.debug('Notification Service Invoked');
        System.debug('Student : ' + app.Student__c);
        System.debug('Status : ' + app.Status__c);

    }

}