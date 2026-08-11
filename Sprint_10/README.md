# Sprint 10 – Student Placement Portal

## Overview

In Sprint 10, I worked on the student placement side of the Salesforce application. The main focus was to build reusable Lightning Web Components (LWC) that allow students to view their profile, browse eligible jobs, and check the applications they have submitted.

The components were developed and tested in a Salesforce Developer Edition org and then added to the project repository.

## Work Completed

### 1. Student Profile

Created a `studentProfile` LWC to display and edit the student's placement-related information.

The component includes:

- Student Name
- Student ID
- Phone
- Email
- Department
- CGPA
- Skills
- Preferred Location
- Status
- Save Profile functionality
- Success feedback after updating the profile

The component loads the existing Student record and allows the user to update the available information.

### 2. Student Portal

Created the `studentPortal` component to bring the main placement features together in one place.

It provides a common view for:

- Student Profile
- Eligible Jobs
- My Applications

This makes it easier for a student to access the different placement features from the Student record page.

### 3. Eligible Jobs / Empty State

The placement page displays jobs that are available to the student.

An `emptyState` component was also created to show a clear message when there is no data available.

The jobs section supports actions such as:

- Viewing job details
- Applying for a job

### 4. My Applications

Created the `myApplications` component to display the applications submitted by the student.

The application information displayed includes:

- Job Title
- Company Name
- Minimum CGPA
- Application Date
- Application Status

A **Refresh Applications** button is also provided so that the application list can be refreshed after an action.

### 5. Application Card

Created a reusable `applicationCard` component for displaying individual application records.

This keeps the application UI separate from the main `myApplications` component and makes the code easier to maintain.

## Components Created

```text
Sprint_10/
│
├── applicationCard/
│   ├── applicationCard.html
│   ├── applicationCard.js
│   ├── applicationCard.js-meta.xml
│   └── __tests__/
│
├── emptyState/
│   ├── emptyState.html
│   ├── emptyState.js
│   ├── emptyState.js-meta.xml
│   └── __tests__/
│
├── myApplications/
│   ├── myApplications.html
│   ├── myApplications.js
│   ├── myApplications.js-meta.xml
│   └── __tests__/
│
├── studentPortal/
│   ├── studentPortal.html
│   ├── studentPortal.js
│   ├── studentPortal.js-meta.xml
│   └── __tests__/
│
└── studentProfile/
    ├── studentProfile.html
    ├── studentProfile.js
    ├── studentProfile.js-meta.xml
    └── __tests__/
