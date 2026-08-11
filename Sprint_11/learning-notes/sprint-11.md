# Sprint 11 Learning Notes

## Queueable Apex

Queueable Apex allows Salesforce code to execute asynchronously.

## Database.AllowsCallouts

`Database.AllowsCallouts` allows the Queueable Apex class to perform HTTP callouts.

## Named Credential

Named Credentials store the endpoint configuration used for external callouts.

## External Credential

External Credentials handle authentication configuration and principals.

## Permission Set

The Permission Set provides access to the External Credential Principal.

## Trigger and Queueable

The Trigger detects when an Application becomes Selected.

The Queueable performs the external API integration asynchronously.

## Integration Status

The Application stores the result of the integration.

Possible values include:

- Pending
- Sent
- Failed
- Retry Required

## Error Handling

Integration errors are stored in:

`Integration_Error__c`

The last attempt is stored in:

`Last_Integration_Attempt__c`

## Idempotency

The Application ID is included as a unique Salesforce reference in the candidate request.

This can be used to identify duplicate submissions during retries.

## Testing Result

The Application status was changed from:

`Applied → Selected`

The trigger automatically created the Queueable job.

Queueable result:

`Completed`

Errors:

`0`

The mock external endpoint returned HTTP 405, which was recorded as an integration error.