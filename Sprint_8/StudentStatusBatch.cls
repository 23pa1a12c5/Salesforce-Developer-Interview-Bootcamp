public with sharing class StudentStatusBatch implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id,
                   Name,
                   Status__c
            FROM Student__c
        ]);
    }
    public void execute(Database.BatchableContext bc, List<Student__c> scope) {

        for (Student__c student : scope) {

            student.Status__c = 'Placed';
        }
        update scope;
        System.debug('Batch processed: ' + scope.size() + ' students');
    }
    public void finish(Database.BatchableContext bc) {
        System.debug('Batch Job Completed');
    }
}