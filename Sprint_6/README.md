
#  Day 6
## Application Service - Campus Placement System

### Overview
This sprint focuses on implementing the business logic for a Campus Placement System using Apex. The `ApplicationService` class manages the complete job application workflow by validating students, checking eligibility, preventing duplicate applications, creating applications, and updating application status.

---

## Technologies Used

- Salesforce Apex
- SOQL (Salesforce Object Query Language)
- DML Operations (Insert, Update)
- Salesforce Custom Objects

---

## Custom Objects

### Student__c
- Name
- Student_ID__c
- CGPA__c
- Department__c
- Email__c
- Status__c

### Job__c
- Name
- Company_Name__c
- Minimum_CGPA__c
- Eligible_Branch__c
- Application_Deadline__c

### Application__c
- Student__c
- Job__c
- Company_Name__c
- Minimum_CGPA__c
- Status__c
- Application_Date__c

---

## Implemented Methods

### getStudent(Id studentId)
Retrieves student details using the Student Id.

### getJob(Id jobId)
Retrieves job details using the Job Id.

### checkDuplicate(Id studentId, Id jobId)
Checks whether the student has already applied for the selected job.

### validateEligibility(Student__c student, Job__c job)
Validates the student's eligibility based on:
- CGPA
- Department/Branch

### createApplication(Student__c student, Job__c job)
Creates a new application record for an eligible student.

### updateApplicationStatus(Id applicationId, String newStatus)
Updates the status of an existing application.

### applyForJob(Id studentId, Id jobId)
Main service method that performs the complete workflow:
1. Retrieves student details.
2. Retrieves job details.
3. Checks for duplicate applications.
4. Validates eligibility.
5. Creates a new application.
6. Returns an appropriate success or validation message.

---

## Workflow

Student
↓
Retrieve Student
↓
Retrieve Job
↓
Check Duplicate
↓
Validate Eligibility
↓
Create Application
↓
Update Status (when required)
↓
Return Response

---

## Features

- Retrieve Student Information
- Retrieve Job Information
- Duplicate Application Validation
- Eligibility Validation
- Application Creation
- Application Status Update
- User-friendly Response Messages

---

## Learning Outcomes

- Apex Classes
- Methods
- SOQL Queries
- DML Operations
- Business Logic Implementation
- Reusable Service Methods
- Salesforce Custom Objects

---

