public with sharing class AlumniService {
    public static void updateAlumni(Application__c app) {
        System.debug('Alumni Service Invoked');
        System.debug('Student : ' + app.Student__c);
        System.debug('Application : ' + app.Id);
    }
}