public with sharing class DailyStudentBatchScheduler implements Schedulable {

    public void execute(SchedulableContext sc) {

        System.debug('Scheduled Job Started');

        Database.executeBatch(new StudentStatusBatch(), 200);

    }
}