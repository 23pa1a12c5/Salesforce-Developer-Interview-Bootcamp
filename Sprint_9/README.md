
# Sprint 9 – Salesforce Development

## Overview

Sprint 9 focused on strengthening Salesforce development fundamentals through practical implementation of Apex, automation, and Lightning development concepts.

The work continued the Placement Management System project and focused on applying Salesforce development concepts through hands-on tasks.

---

## Topics Covered

- Apex Development
- Apex Classes
- Business Logic and Service Layer
- Trigger-Based Processing
- Lightning Web Components (LWC)
- Salesforce Data Access
- SOQL Queries
- Record Processing
- Separation of UI and Business Logic
- Salesforce Metadata and Deployment

---

## Practical Tasks Completed

### 1. Apex Development

Created and worked with Apex classes to implement reusable business logic.

The Apex classes were structured so that business logic could be separated from the user interface and trigger logic.

---

### 2. Service Layer

Implemented service-oriented Apex logic for handling application-related operations.

The service layer is responsible for operations such as:

- Retrieving Student records
- Retrieving Job records
- Checking duplicate applications
- Validating student eligibility
- Creating Application records
- Updating application status

---

### 3. Trigger-Based Processing

Worked with Salesforce triggers to invoke business logic when records are created or updated.

The trigger delegates the actual business processing to appropriate Apex service classes instead of containing large amounts of business logic directly inside the trigger.

---

### 4. Lightning Web Components

Worked with Lightning Web Components to display Salesforce data in the user interface.

The LWC structure includes:

- HTML template
- JavaScript controller
- Metadata configuration
- Apex integration

---

### 5. Apex and LWC Integration

Connected Lightning Web Components with Apex methods using Salesforce Apex annotations such as:

```apex
@AuraEnabled
