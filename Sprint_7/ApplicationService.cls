public with sharing class ApplicationService {
    public static Student__c getStudent(Id studentId) {

        Student__c student = [
            SELECT Id,
                   Name,
                   Student_ID__c,
                   CGPA__c,
                   Department__c
            FROM Student__c
            WHERE Id = :studentId
            LIMIT 1
        ];

        return student;
    }
    public static Job__c getJob(Id jobId) {
    
        Job__c job = [
            SELECT Id,
                   Name,
                   Company_Name__c,
                   Minimum_CGPA__c,
                   Eligible_Branch__c,
                   Application_Deadline__c
            FROM Job__c
            WHERE Id = :jobId
            LIMIT 1
        ];
    
        return job;
    }
    public static Boolean checkDuplicate(Id studentId, Id jobId) {
    
        Integer count = [
            SELECT COUNT()
            FROM Application__c
            WHERE Student__c = :studentId
            AND Job__c = :jobId
        ];
    
        return count > 0;
    }
    public static Boolean validateEligibility(Student__c student, Job__c job) {
        
        Boolean cgpaEligible = student.CGPA__c >= job.Minimum_CGPA__c;
        Boolean branchEligible = student.Department__c == job.Eligible_Branch__c;
        return cgpaEligible && branchEligible;
    }
    public static Application__c createApplication(Student__c student, Job__c job) {

        Application__c application = new Application__c();
    
        application.Student__c = student.Id;
        application.Job__c = job.Id;
        application.Company_Name__c = job.Company_Name__c;
        application.Minimum_CGPA__c = job.Minimum_CGPA__c;
        application.Status__c = 'Applied';
        application.Application_Date__c = Date.today();
    
        insert application;
    
        return application;
    }
    public static void updateApplicationStatus(Id applicationId, String newStatus) {

        Application__c application = [
            SELECT Id, Status__c
            FROM Application__c
            WHERE Id = :applicationId
            LIMIT 1
        ];
    
        application.Status__c = newStatus;
    
        update application;
	}
    public static String applyForJob(Id studentId, Id jobId) {
        Student__c student = getStudent(studentId);
        Job__c job = getJob(jobId);
        Boolean duplicate = checkDuplicate(studentId, jobId);
        if (duplicate) {
            return 'You have already applied for this job.';
        }
        Boolean eligible = validateEligibility(student, job);    
        if (!eligible) {
            return 'You are not eligible for this job.';
        }    
        Application__c application = createApplication(student, job);    
        return 'Application Submitted Successfully.';
    }
    public static void validateApplication(Application__c app){
    
        Student__c student = getStudent(app.Student__c);
    
        Job__c job = getJob(app.Job__c);
    
        if(checkDuplicate(student.Id, job.Id)){
            app.addError('You have already applied for this job.');
            return;
        }
    
        if(!validateEligibility(student, job)){
            app.addError('Student is not eligible.');
            return;
        }
	}
    public static void updatePlacementStatistics(Application__c app) {
    	System.debug('Student selected for Job: ' + app.Job__c);
}
    
    
}