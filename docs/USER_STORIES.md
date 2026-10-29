
# NovaRetail 360 - User Stories

## US-001 - Lead Capture
As a Sales Representative,
I want customer enquiries to be captured as Leads,
so that I can follow up with prospective customers.

Acceptance Criteria:
- Valid submissions create Salesforce Lead records.
- New leads have an initial status.
- Required information is validated.

## US-002 - Lead Assignment
As a Sales Manager,
I want leads assigned automatically,
so that sales representatives receive new enquiries.

Acceptance Criteria:
- Leads are routed using defined assignment criteria.
- The assigned user can access the record.

## US-003 - Opportunity Management
As a Sales Representative,
I want to track opportunities through sales stages,
so that I can manage my sales pipeline.

Acceptance Criteria:
- Opportunities have Stage, Amount and Close Date.
- Sales managers can view pipeline reports.

## US-004 - Case Management
As a Support Agent,
I want customer complaints captured as Cases,
so that I can track and resolve them.

Acceptance Criteria:
- Cases are linked to the relevant customer.
- Cases have Priority, Status and Issue Category.
- Cases can be assigned to a support queue.

## US-005 - Case Escalation
As a Support Manager,
I want overdue cases to be escalated,
so that important customer issues are prioritized.

Acceptance Criteria:
- SLA deadlines are defined.
- Overdue cases are identified.
- An escalation notification is triggered.

## US-006 - Deployment Automation
As a Salesforce Developer,
I want GitHub Actions to validate and deploy metadata,
so that deployments are repeatable and testable.

Acceptance Criteria:
- GitHub stores the project source.
- Pipeline runs validation and automated tests.
- Deployment results are visible in GitHub Actions.
- Credentials are not committed to the repository.
