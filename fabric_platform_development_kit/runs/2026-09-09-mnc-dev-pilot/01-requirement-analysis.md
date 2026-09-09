---
run_id: "2026-09-09-mnc-dev-pilot"
stage: requirement-analysis
status: approved
approved_by: "User (explicit conversation approval)"
approved_at: "2026-09-09"
source: "User request, subsequent corrections and explicit Stage 1 approval in this conversation"
created: "2026-09-09"
---

## Business objective
Provide MNC Pvt. Ltd. with a small, private-by-default Fabric foundation for its Milestone-1 dev pilot and September 9 demo, using the Fabric Platform Development Kit and the existing CAF/WAF-grounded pattern.

## Functional requirements
- One F2 Fabric capacity, carrying forward the user's explicit selection.
- Exactly one dev workspace assigned to that capacity.
- North Europe (`northeurope`), replacing Sweden Central per the user's correction.
- Create resource group `rg-mnc-milestone1-dev-se`; treat it as currently absent per the user's latest statement, superseding the earlier creation report.
- No capacity or workspace was successfully created in the prior attempts.

## Non-functional requirements
- Approximately 30 peak concurrent sessions; acceptable response time unspecified.
- Private-by-default access using existing protection the user confirmed covers this deployment.
- Small, incrementally scalable capacity following the referenced CAF/WAF pattern.
- No compliance constraints stated.
- Budget, availability and support requirements remain unspecified.

## Impacted platform components
| Domain | Scope | Reference |
|---|---|---|
| Compute | One F2 capacity | PLAT-COMP-0001, PLAT-ADR-0001 |
| Landing zone | Single dev workspace and environment boundary | PLAT-LZ-0001 |
| Network | Existing protection dependency only | PLAT-NET-0001 |
| Identity-security | Existing access dependency only | PLAT-SEC-0001 |
| Storage | Excluded | None |
| Operations | Excluded | None |

## Assumptions
- Earlier F2 and private-access confirmations remain applicable; the latest location and resource-group correction takes precedence.
- F2 is the selected starting tier; performance for 30 sessions is not demonstrated.
- The validated 800 GB/150-session workload is a separate profile and will not replace this pilot's inputs.

## Open questions
- [NEEDS HUMAN INPUT: Milestone-1 data volume, workload mix and refresh overlap]
- [NEEDS HUMAN INPUT: acceptable response time for 30 concurrent sessions]
- [NEEDS HUMAN INPUT: pilot budget and applicability of existing dev/test guardrails]
- [NEEDS HUMAN INPUT: tenant-native capacity administrator]
- [NEEDS HUMAN INPUT: availability and support requirements]

## Risks
- Unknown workload characteristics may exceed F2 capacity.
- The prior administrator rejection remains unresolved.
- [CONFLICT NEEDS HUMAN RESOLUTION] The sandbox deployment target has not been established as satisfying PLAT-LZ-0001's dedicated dev-subscription boundary.

## Out of scope
Storage, network changes, identity-security changes, operations, test and prod environments. Required kit validation remains part of the workflow. The kit produces a deployment-readiness package rather than executing deployment.
