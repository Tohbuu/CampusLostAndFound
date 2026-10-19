# Project Decision Register

This file preserves the approved design baseline. It is not proof that
the corresponding functionality has already been implemented or tested.

## M0 — Project baseline

The system is a central-campus lost-and-found application for reporting,
discovering, claiming, and resolving lost/found items.

Approved direction:
- Flutter/Dart and Firebase.
- Google authentication; any Google account is permitted.
- Sign-in is required for report discovery and protected workflows.
- Roles include regular users, report owners, moderators, and trusted
  administrators.
- Privileged roles are assigned only through an authorized process.
- Report CRUD, search/filter, claims, moderation, security rules,
  validation, error handling, tests, documentation, and a live demo
  are in scope.
- Android first; validate other Flutter platforms individually.
- Soft-delete reports when history must be retained.
- Notifications are deferred until core workflows pass acceptance tests.

Out of scope unless separately approved:
payments, public contact details, AI matching, GPS tracking, a separate
website/backend beyond required trusted operations, complex analytics,
push notifications, and university identity-system integration.

## M1.1 — UX direction

Provisional brand: FOUND.

Provisional visual direction: deep blue, mint, and warm sand; fictional
sample data; custom, cohesive, intuitive UI rather than default templates.

Primary destinations:
- Home
- Discover
- Report
- My Activity
- Profile & Settings

Screens/workflows include authentication, report lists and details,
search/filter, report creation, claims, claim review, user activity,
moderation, disputes, and audit history.

The UI must provide loading, empty, error/retry, success, and validation
states. Status and role-specific actions must be clear. Sensitive
identifying evidence must not appear in public report views.

## M1.2 — Architecture

Approved feature-first layered architecture:
- Presentation
- Domain
- Data
- External services

Proposed feature areas:
auth, reports, claims, moderation, and profile, with shared app/core
infrastructure.

Repository contracts:
AuthRepository, UserRepository, ReportRepository, ClaimRepository,
ModerationRepository, and PhotoStorageRepository.

State-management and routing packages remain to be selected.
Dependencies must be composed centrally; asynchronous work and streams
must have clear ownership and disposal.

Security-sensitive operations may require a trusted backend.
A client transaction alone is not a complete authorization boundary.

## M1.3 — Data model direction

Proposed Firestore collections:

1. users/{uid}
   Profile information, role, and timestamps.

2. reports/{reportId}
   Owner, lost/found type, title, description, category, location,
   event date, photo paths where supported, lifecycle state, timestamps,
   and optional deletion metadata.

3. claims/{claimId}
   Report and claimant references, claim state, evidence reference,
   optional reviewer information, and timestamps.

4. claimEvidence/{evidenceId}
   Separate protected claim-identifying information.

5. moderationRecords/{recordId}
   Target, moderator, action, reason, and creation timestamp.

6. lifecycleEvents/{eventId}
   Report/claim references, event type, actor identity and role at the
   time, optional reason, server-generated timestamp, and previous and
   resulting states.

This is a working baseline, not a finalized schema. Exact fields,
validation, queries, indexes, and authorization rules must be verified.

## M1.3 — Evidence and audit decisions

- Claim evidence uses private text-based identifying details.
- Store evidence separately from public report data.
- Do not expose evidence in discovery, report cards, or unrestricted URLs.
- Do not request government IDs, passwords, payment details, or
  unnecessary sensitive information.
- Evidence photos/attachments are excluded from the initial MVP unless
  separately approved after feasibility review.
- Retention and deletion rules must be documented.
- Closing or soft-deleting a report must not silently destroy evidence
  required for an active claim or dispute.
- moderationRecords and lifecycleEvents are separate append-only
  application histories. Corrections are new events, not edits.
- Application-level append-only behavior does not guarantee protection
  from privileged infrastructure operators.

## M1.4.1 — Authorization matrix

Authenticated users:
- Browse permitted reports.
- Create reports and submit eligible claims.
- Access their own activity.

Report owners:
- Manage their own eligible reports.
- Review claims on their own found reports.
- Confirm physical handover only for their found report.

Claimants:
- View/manage their own eligible claims and authorized evidence.
- Withdraw their own pending claim.

Moderators:
- Review eligible reports and disputes.
- Cancel a handover with a reason where authorized.
- Authorize abandoned-handover recovery.
- Reopen eligible closed/resolved reports.

Trusted administrators:
- Manage privileged roles through an authorized process.

Trusted backend:
- Perform only explicitly authorized sensitive operations that cannot
  safely be enforced by client operations and security rules alone.

UI-hidden controls are not authorization. Firestore Rules are not query
filters. Backend code using the Firebase Admin SDK must perform its own
authorization and state validation.

## M1.4.2 — Sensitive transitions

### Accept a claim
Preconditions: report is available; selected claim is pending.
Result: report becomes return_in_progress; selected claim becomes
handover_pending. Only the report owner may accept an eligible claim.
Competing pending claims remain pending during handover.

### Confirm physical handover
Preconditions: report is return_in_progress; selected claim is
handover_pending.
Result: report becomes returned; selected claim becomes completed.
Only the found-report owner may confirm physical handover.
Record the confirmer and server timestamp.

### Finalize competing claims
After the successful handover's atomic state transition, a trusted
backend rejects remaining eligible pending claims in manageable batches.
The returned report must not accept new claims or handovers while this
finalization is in progress. Retries must be safe.

### Cancel an active handover
The report owner or an authorized moderator may cancel with a reason.
Revalidate current state. If eligible, restore the report to available
and the selected claim to pending. Do not blindly restore stale state.

### Recover abandoned handover
A moderator authorizes recovery. The executing operation revalidates
current state before changing it.

### Retry behavior
Distinguish an already-successful operation from a stale or conflicting
request. Never claim success when the requested transition did not occur.
Retries must not duplicate transitions or overwrite newer state.

Firestore transactions and rules should be used where sufficient.
Trusted backend operations are required where authorization, atomicity,
or multi-document processing cannot be safely guaranteed on the client.
Storage operations are not atomic with Firestore operations.

## M1.4.3 — Security and query direction

- Deny by default.
- Enforce Firestore and Storage permissions independently.
- Keep profiles private by default and expose minimal display information.
- Restrict claim evidence to the claimant, relevant report owner, and
  authorized moderators according to the final evidence policy.
- Design queries together with Rules; Rules do not filter unauthorized
  documents out of results.
- Use cursor pagination and stable ordering.
- Handle permission denial, empty results, missing indexes, and
  transient failures.
- Validate queries, indexes, pagination, and Rules against the final
  schema and realistic data.

Candidate query shapes:
- Active reports by status/type/category/location, newest first.
- Reports by owner UID.
- Claims by claimant UID.
- Claims for a report, subject to owner/moderator authorization.
- Actionable moderation queue.
- Lifecycle events by report.
- Restricted moderation history by target or queue.
- Evidence fetched only by authorized identities.

## M1.5 — Consolidated data contract

The six collections and the core lifecycle/security direction above
are the working baseline. The following remain unresolved and must not
be silently treated as final:
- Complete report state vocabulary and all allowed transitions.
- Closure, dispute, and deletion transition details.
- Final evidence fields and visibility policy.
- Audit-history visibility.
- Exact trusted-backend and transaction boundaries.
- Retention, restoration, and recovery policy.
- Query/index validation against the final schema and Rules.

## M1.6.1 — Report lifecycle

Working states:
- Lost reports: active, resolved, closed.
- Found reports: available, return_in_progress, returned, closed.

Lifecycle state is separate from provisional moderation state
(none, under_review, disputed) and deletion metadata (deletedAt).

- Reopening closed/resolved reports requires a moderator.
- Restoring a soft-deleted report is a separate privileged workflow.
- Cancellation/recovery may return return_in_progress to available only
  through an authorized operation that revalidates state.
- Closing/resolving does not delete claim or audit history.
- Soft-deleted reports are excluded from ordinary discovery and cannot
  receive new claims.
- This is a working baseline; every transition still needs validation.

## M1.6.2 — Claim withdrawal and cancellation

- Claimants may withdraw only their own pending claims.
- withdrawn is a terminal state in the ordinary claim workflow.
- Owner rejection is a distinct transition to rejected.
- A claimant cannot withdraw a handover_pending claim.
- Handover cancellation is a separate authorized operation.
- Closed/deleted reports do not accept new claims or ordinary claim
  actions.
- Record reasons for owner rejection, handover cancellation, and
  moderator recovery where specified; claimant withdrawal reason
  is optional.
- Concurrent/stale operations must fail safely.

## M1.6.3 — Claim evidence

Approved:
- Private text-based identifying details.
- Evidence stored separately from public report data.
- Exclude evidence photos/attachments from the initial MVP.
- Protect evidence access using actual backend security rules, not UI
  visibility alone.
