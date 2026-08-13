# Salesforce Developer Interview Bootcamp

## Sprint 12 - Deployment Workflow

This project contains the Salesforce development work completed during the bootcamp. Sprint 12 focuses on source control, Salesforce CLI, metadata deployment, testing, and verification.

## Prerequisites

- Git
- Salesforce CLI
- Access to a Salesforce Developer or test org
- Required permissions to retrieve and deploy Salesforce metadata

## Clone

Clone the repository and open the project folder:

```bash
git clone https://github.com/23pa1a12c5/Salesforce-Developer-Interview-Bootcamp
cd CarServiceCenter

```

## Authenticate

Authenticate your Salesforce org using Salesforce CLI:

```bash
sf org login web
```

Verify the connected org:

```bash
sf org list
```

## Retrieve Metadata

Retrieve Salesforce metadata from the target org:

```bash
sf project retrieve start --target-org <ORG_ALIAS>
```

Retrieved metadata is stored under:

```text
force-app/main/default/
```

## Deploy

Deploy Salesforce metadata to the target org:

```bash
sf project deploy start --target-org <ORG_ALIAS>
```

Always verify the target org before deployment.

## Test

Run the required Apex tests after deployment and verify that the tests complete successfully.

## Verify

After deployment, verify:

- Apex classes
- Apex triggers
- Lightning Web Components
- Custom objects
- Custom fields
- Application functionality

## Git Workflow

The Sprint 12 deployment workflow follows:

```text
Create Feature Branch
        ↓
Make Changes
        ↓
Git Status
        ↓
Git Add
        ↓
Git Commit
        ↓
Git Push
        ↓
Pull Request
        ↓
Code Review
        ↓
Merge
```

## Troubleshooting

### Authentication Failure

Check the connected Salesforce organizations:

```bash
sf org list
```

Re-authenticate if necessary.

### Deployment Failure

Review the Salesforce CLI deployment output and identify the metadata component or dependency causing the failure.

### Test Failure

Review the failed Apex test results and fix the underlying issue before completing the deployment.

### Git Conflict

Check the repository status:

```bash
git status
```

Resolve the conflicting files, stage them, and continue the Git workflow.

## Conclusion

Sprint 12 demonstrates the Salesforce deployment workflow using Git and Salesforce CLI, including authentication, metadata retrieval, deployment, testing, verification, and source control.