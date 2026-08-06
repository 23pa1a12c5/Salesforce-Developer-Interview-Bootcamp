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
    public static void validateApplications(List<Application__c> applications) {

        Set<Id> studentIds = new Set<Id>();
        Set<Id> jobIds = new Set<Id>();
    
        for (Application__c app : applications) {
    
            if (app.Student__c != null) {
                studentIds.add(app.Student__c);
            }
    
            if (app.Job__c != null) {
                jobIds.add(app.Job__c);
            }
        }
        Map<Id, Student__c> studentsById = new Map<Id, Student__c>([
            SELECT Id,
                   CGPA__c,
                   Department__c
            FROM Student__c
            WHERE Id IN :studentIds
        ]);
        Map<Id, Job__c> jobsById = new Map<Id, Job__c>([
            SELECT Id,
                   Minimum_CGPA__c,
                   Eligible_Branch__c
            FROM Job__c
            WHERE Id IN :jobIds
        ]);
        Set<String> existingApplications = new Set<String>();   
        for (Application__c existingApp : [
            SELECT Student__c,
                   Job__c
            FROM Application__c
            WHERE Student__c IN :studentIds
            AND Job__c IN :jobIds
        ]) {
    
            existingApplications.add(
                existingApp.Student__c + '-' + existingApp.Job__c
            );
        }    
        for (Application__c app : applications) {
    
            Student__c student = studentsById.get(app.Student__c);
            Job__c job = jobsById.get(app.Job__c);
    
            if (student == null || job == null) {
                continue;
            }    
            String key = app.Student__c + '-' + app.Job__c;
    
            if (existingApplications.contains(key)) {
                app.addError('You have already applied for this job.');
                continue;
            }
    
            if (!validateEligibility(student, job)) {
                app.addError('Student is not eligible.');
            }
        }
    }
    public static void processSelectedApplications(
    List<Application__c> newApplications,
    Map<Id, Application__c> oldApplicationMap
) {

    Set<Id> selectedStudentIds = new Set<Id>();

    for (Application__c app : newApplications) {

        Application__c oldApp = oldApplicationMap.get(app.Id);

        if (oldApp.Status__c != 'Selected' &&
            app.Status__c == 'Selected') {

            selectedStudentIds.add(app.Student__c);
        }
    }

    if (selectedStudentIds.isEmpty()) {
        return;
    }

    List<Student__c> studentsToUpdate = [
        SELECT Id,
               Status__c
        FROM Student__c
        WHERE Id IN :selectedStudentIds
    ];

    for (Student__c student : studentsToUpdate) {
        student.Status__c = 'Placed';
    }

    update studentsToUpdate;
}
    
}