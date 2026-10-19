# Campus Lost and Found System

A Flutter and Firebase application for a campus community to report,
discover, claim, and resolve lost and found items.

## Project status

- Phase: Implementation
- First implementation checkpoint: M2.0
- Primary platform: Android
- Additional targets: Web and Linux desktop, each subject to validation
- Design baseline: M0 through M1.6.3
- Submission target: second deadline October 21, 2026;
  possible final submission around October 26, 2026.
- Deadline dates are planning targets and must be confirmed against
  the instructor's actual requirements.

## Approved technology direction

- Flutter and Dart
- Firebase Authentication with Google sign-in
- Cloud Firestore
- Firebase Storage is not required for initial claim evidence.
- A trusted backend will be used for sensitive operations where
  client-side transactions and security rules are insufficient.

Exact dependency versions, Firebase configuration, backend boundaries,
and deployment requirements must be verified before implementation.

## Core user journeys

1. Sign in with Google.
2. Browse and search permitted lost/found reports.
3. Create and manage eligible reports.
4. Submit a claim with private text-based identifying details.
5. Review claims on a found report.
6. Accept a claim, arrange physical handover, and confirm handover.
7. Use authorized moderation and recovery workflows when necessary.

## Architecture

Use a feature-first, layered architecture:

- Presentation: screens, widgets, navigation, forms, UI state.
- Domain: entities, repository contracts, use cases, state transitions.
- Data: repositories, DTOs, mapping, Firebase queries and streams.
- External services: Firebase Authentication, Firestore, and any
  explicitly approved trusted backend.

See docs/DECISIONS.md and docs/IMPLEMENTATION_PLAN.md.

## Development rules

- Do not commit credentials, tokens, private claim evidence, or secrets.
- UI restrictions are not authorization.
- Firestore and Storage security rules must enforce access independently.
- Never allow clients to grant themselves privileged roles.
- Test real authorization behavior, not only the visual interface.
- Do not silently change approved decisions. Record proposals, approvals,
  unresolved questions, and deferred work separately.
- A design approval does not automatically authorize implementation
  of unrelated changes.
