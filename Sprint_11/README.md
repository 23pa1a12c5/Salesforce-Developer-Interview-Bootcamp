# Sprint 11 – External Recruitment Integration

## Overview

Sprint 11 implements an asynchronous integration between Salesforce and an external recruitment system.

When an Application status changes to `Selected`, an Apex Trigger automatically starts a Queueable Apex job.

The Queueable retrieves candidate information, creates a JSON request, and sends it to the external recruitment API using a Named Credential.

## Integration Flow

Application
↓
ApplicationTrigger
↓
CandidateSyncQueueable
↓
Named Credential
↓
External Recruitment API
↓
Response Processing
↓
Application Integration Status

## Components

### ApplicationTrigger

Runs after an Application is updated.

When the status changes to `Selected`, it enqueues `CandidateSyncQueueable`.

### CandidateSyncQueueable

The Queueable:

1. Retrieves Application and related Student/Job information.
2. Builds the candidate JSON payload.
3. Sends a POST request.
4. Processes the response.
5. Updates integration fields.

## Authentication

Named Credential:

`External_Recruitment_API`

External Credential:

`External_Recruitment_API`

Access is provided through a Permission Set and External Credential Principal.

## Integration Tracking

The Application record stores:

- Integration Status
- External Candidate ID
- Last Integration Attempt
- Integration Error

## Testing

The automatic flow was tested by changing:

`Applied → Selected`

The Queueable job was created automatically.

Latest result:

- Status: Completed
- Number of Errors: 0

The mock endpoint returned HTTP 405 during testing, which was captured by the integration error handling.

## Key Learning

This sprint demonstrates:

- Queueable Apex
- Asynchronous processing
- Apex Triggers
- HTTP Callouts
- Named Credentials
- External Credentials
- Permission Sets
- JSON serialization
- Error handling
- Integration tracking
- Retry handling
- Idempotency