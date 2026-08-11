# Candidate API Contract

## Purpose

This API is used to send selected student candidates from the Salesforce Placement Management System to an external recruitment platform.

## Endpoint

POST /candidates

## Request

### Method

POST

### Content-Type

application/json

### Request Body

```json
{
  "studentId": "STU10045",
  "name": "Mahesh",
  "email": "mahesh@example.com",
  "branch": "IT",
  "cgpa": 8.5,
  "jobId": "JOB1001",
  "company": "TCS",
  "role": "Software Developer",
  "selectionDate": "2026-08-11"
}