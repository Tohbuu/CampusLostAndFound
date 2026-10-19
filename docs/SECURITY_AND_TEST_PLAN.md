# Security and Test Plan

This is the planned test inventory. Tests must be marked passed only
after they have actually been executed and the result recorded.

## Authentication
- Signed-out users cannot access protected workflows.
- Successful Google sign-in creates the expected session.
- Sign-out and session restoration behave correctly.
- Auth failures show a recoverable error.

## Reports
- Authenticated user can create a valid report.
- Invalid required fields are rejected.
- Owner can edit an eligible report.
- Another ordinary user cannot edit or delete someone else's report.
- Soft-deleted reports do not appear in ordinary discovery.
- Closed/deleted reports reject new claims.

## Claims and evidence
- Eligible user can claim another user's found report.
- Owner cannot claim their own found report.
- Claimant can access their own permitted claim.
- Unrelated user cannot read private evidence.
- Relevant report owner and authorized moderators can access evidence
  only as permitted by the final policy.
- Evidence is never included in public report queries or cards.
- Claimant can withdraw only a pending claim.
- Claimant cannot withdraw a handover_pending claim.

## Handover and concurrency
- Only eligible owner can accept a pending claim.
- Concurrent accept attempts cannot produce multiple active handovers.
- Only the found-report owner can confirm physical handover.
- Successful confirmation makes the report returned and claim completed.
- Retry after successful completion does not create duplicate transitions.
- Stale/conflicting requests fail safely.
- Cancellation/recovery revalidates state and records required reason.
- Remaining pending claims are safely rejected in backend batches.

## Moderation and audit
- Ordinary users cannot self-assign moderator/admin roles.
- Moderator actions are limited to authorized workflows.
- Reopening closed/resolved reports requires moderator authorization.
- Restoring soft-deleted reports is privileged.
- lifecycleEvents and moderationRecords are separate.
- Ordinary application operations cannot edit/delete audit records.
- Backend event creation validates actor, operation, and state.

## Infrastructure and queries
- Firestore Rules deny access by default.
- Storage Rules are independently enforced if Storage is used.
- Queries are compatible with security rules.
- Index errors and permission errors are handled without false success.
- Pagination is stable and does not silently skip/duplicate results.
- Secrets are excluded from Git.
