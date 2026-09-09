---
run_id: "2026-09-09-mnc-dev-pilot"
stage: gap-analysis
status: approved
approved_by: "User (explicit conversation approval)"
approved_at: "2026-09-09"
created: "2026-09-09"
---

## Gap register
Comparison uses only approved 01-requirement-analysis.md and 02-current-state-assessment.md.

| Gap | Requirement versus current coverage | Classification |
|---|---|---|
| G1 | F2 capacity required; capacity module exists, spec SKU unresolved, dev example uses F32. | PARTIAL |
| G2 | Exactly one assigned dev workspace required; workspace module exists, pilot name and capacity reference unresolved. | PARTIAL |
| G3 | North Europe required; spec region unresolved, example uses West Europe. Example values are not approved deployment decisions. | PARTIAL |
| G4 | Create rg-mnc-milestone1-dev-se; resource-group module exists, pilot configuration not recorded. | PARTIAL |
| G5 | Dev-only scope; current dev root also invokes storage, networking, security and monitoring components. | PARTIAL |
| G6 | Private access confirmed by user; design supports it, assessment contains no deployment-specific verification. | PARTIAL |
| G7 | Approximately 30 concurrent sessions; workload measurements and acceptable response time unknown. | PARTIAL |
| G8 | Pilot cost expectations; budget and applicability of existing guardrails unresolved. | PARTIAL |
| G9 | Availability and support expectations unspecified. | MISSING |
| G10 | Dedicated dev boundary required by PLAT-LZ-0001; sandbox alignment unresolved. [CONFLICT NEEDS HUMAN RESOLUTION] | CONFLICT |
| G11 | Capacity administrator required; examples contain placeholders and prior rejection remains unresolved. | PARTIAL |
| G12 | Kit validation required; no completed readiness report exists and Terraform was previously unavailable. | PARTIAL |

## Architectural impact
- G1-G4: Additive compute and landing-zone configuration; existing module capabilities are recorded.
- G5: Changes to environment composition affect excluded domains unless carefully scoped.
- G6, G11: Existing network and identity dependencies. Creating replacement controls would expand approved scope.
- G7-G9: Additional requirements and acceptance criteria; changes to validated decisions need explicit approval.
- G10: [CONFLICT NEEDS HUMAN RESOLUTION] A sandbox exception could change the validated landing-zone boundary.
- G12: Validation evidence and tooling readiness; no additional platform domain implied.

## Risks and dependencies
- High: G5 could introduce out-of-scope resources; G10 affects governance alignment; G11 blocks capacity creation.
- High for readiness: G6 prevents an independently verified privacy claim; G12 prevents a validated deployment handoff.
- Medium: G1-G4 must agree across contract and implementation. G7-G9 prevent substantiated performance, cost and service-level claims.

## Items requiring human input before design can start
- [CONFLICT NEEDS HUMAN RESOLUTION] Confirm whether sandbox satisfies dedicated dev boundary or requires an approved exception.
- [NEEDS HUMAN INPUT: Milestone-1 data volume, workload mix and refresh overlap]
- [NEEDS HUMAN INPUT: acceptable response time for 30 concurrent sessions]
- [NEEDS HUMAN INPUT: pilot budget and applicability of existing dev/test guardrails]
- [NEEDS HUMAN INPUT: tenant-native capacity administrator]
- [NEEDS HUMAN INPUT: availability and support requirements]
- Unknown workload details need not prevent designing an F2 foundation, but its 30-session performance cannot be accepted as proven.

## Items with no gap
Validated design supports Microsoft Fabric, incremental capacity scaling and dev environment separation. F2, North Europe and resource-group name are settled requirements. No additional compliance requirement stated. Approval records gaps; it does not resolve them.
