# Implementation Plan and Checkpoints

Planning dates are targets, not guarantees. The second deadline is
understood to be October 21, 2026, and the possible final submission
date is around October 26, 2026. Confirm exact requirements with the
instructor.

## M2.0 — Environment and scaffold
Acceptance:
- Flutter project runs on at least one available target.
- Git repository exists and baseline is committed.
- Approved decisions and unresolved work are recorded in docs.
- No secrets or claim evidence are committed.
- Dependencies and environment are recorded.

## M2.1 — Authentication and reports
Acceptance:
- Google authentication and session handling work.
- Firestore connection is verified.
- Users can create, browse, view, and edit eligible reports.
- Access rules are tested against multiple user identities.
- Validation and basic loading/empty/error states are present.

## M2.2 — October 21 demonstrable checkpoint
Acceptance:
- A reproducible build launches.
- At least one real report can be written to and read from Firestore.
- Authentication and core report flow can be demonstrated.
- Known gaps and test results are documented honestly.

## M3 — Claims and private text evidence
Acceptance:
- Eligible users can submit claims.
- Evidence is separate from public report data.
- Unauthorized users cannot read private evidence.
- Claimants can see their own claim activity.
- A claimant cannot claim their own found report.

## M4 — Lifecycle and moderation
Acceptance:
- Eligible claims can be accepted/rejected.
- Handover is a two-step process: accept, then owner confirms physical
  handover.
- Successful claim ends as completed; report ends as returned.
- Handover cancellation/recovery revalidates current state.
- Remaining pending claims are rejected through safe backend batching.
- Lifecycle and moderation histories are separate and append-only at
  the application level.
- Role checks are tested, not merely hidden in the UI.

## M5 — Security and reliability
Acceptance:
- Firestore Rules tested for allowed and denied access.
- Evidence privacy tested.
- Stale requests and safe retries tested.
- Query/index/pagination behavior checked.
- Deletion, restoration, and retention limitations documented.
- No unreviewed production credentials in source control.

## M6 — Documentation and demonstration
Acceptance:
- System guide: overview, personas, wireframes, architecture, schema,
  and setup instructions.
- Itemized UI, functional, authentication, and database test cases.
- Results correspond to tests actually executed.
- Demo rehearsed from a clean launch.
- Submission package and limitations verified.

## Deferred features
Photo evidence uploads, push notifications, complex analytics, AI
matching, GPS tracking, and other excluded features stay deferred unless
core acceptance criteria are complete and additional scope is approved.

## Required feasibility checks
1. First administrator provisioning and recovery.
2. Final evidence visibility policy for Firestore and any Storage paths.
3. Minimum reporter profile information exposed.
4. Firebase plan, quota, cost, and trusted-backend feasibility.
5. Query/index/pagination validation against schema and Rules.
6. Security test plan and isolated test environment before live deployment.
7. Complete report and claim transition table.
8. Retention, deletion, and restoration behavior.
