# Sprint 11 Architecture

## Integration Flow

```text
Application
     |
     | Status changes to Selected
     v
ApplicationTrigger
     |
     | System.enqueueJob()
     v
CandidateSyncQueueable
     |
     | HTTP POST
     v
Named Credential
     |
     v
External Recruitment API
     |
     | HTTP Response
     v
CandidateSyncQueueable
     |
     v
Application Integration Fields