---
run_id: "2026-09-09-mnc-dev-pilot"
stage: current-state-assessment
status: approved
approved_by: "User (explicit conversation approval)"
approved_at: "2026-09-09"
created: "2026-09-09"
---

## Scope of assessment
Compute and landing zone; existing network and identity protection as dependencies only, per approved 01-requirement-analysis.md. This is a repository assessment, not a live-cloud verification.

## Platform inventory
| Validated entities | Current recorded position |
|---|---|
| PLAT-COMP-0001, PLAT-ADR-0001 | Start small and scale using measured workload; existing profile is 800 GB/150 sessions. |
| PLAT-LZ-0001 | Separate environment subscriptions, standard naming and tags. |
| PLAT-NET-0001, PLAT-ADR-0002 | Private-by-default connectivity, central DNS and approved public-access exceptions. |
| PLAT-SEC-0001, PLAT-ADR-0003 | Entra ID, group-based least privilege and managed identities. |
| PLAT-ADR-0004 | Terraform providers for Azure and Fabric control planes; protected remote state. |

## Spec state
| File / field | Current value |
|---|---|
| platform-spec/organization.yaml: shared.managementGroup | Data-Analytics |
| platform-spec/organization.yaml: metadata.organization, shared.region, shared.subscriptions.dev, shared.namingConvention | Human-input markers |
| platform-spec/environments/dev.yaml: platform.capacity.mode | Microsoft Fabric capacity |
| platform-spec/environments/dev.yaml: platform.region, platform.capacity.sku, platform.capacity.capacityId, platform.workspaces[0].name, platform.workspaces[0].capacityRef, platform.workspaces[0].domain | Human-input markers |
| platform-spec/environments/dev.yaml: platform.network.posture | private-by-default |
| platform-spec/environments/dev.yaml: platform.identity.authentication | Microsoft Entra ID |

## IaC state
- iac/modules/azure-landing-zone creates resource groups and optionally associates a subscription with a management group.
- iac/modules/fabric-capacity creates a parameterized Fabric capacity.
- iac/modules/fabric-workspace creates workspaces assigned by Fabric capacity GUID. Workspace identity defaults to enabled.
- iac/environments/dev/terraform.tfvars.example specifies West Europe, F32 and fw-dp-dev-core, with placeholder subscription and administrator values.
- iac/environments/dev/main.tf also invokes networking, storage, Key Vault, RBAC and monitoring modules.
- The capacity and workspace modules contain no Fabric Private Link or public-access-blocking configuration.

## Architecture summary
The repository separates validated design, generated YAML and Terraform implementation. Azure resources and Fabric workspaces use separate providers. Existing Terraform describes a broader platform foundation.

## Known open items already on record
- open-questions/oq_ans/2026-08-31-platform-input-answer.md describes the earlier workload and marks its questionnaire answered.
- Approved Stage 1 retains unresolved data volume, workload mix, response-time target, budget, tenant-native administrator, availability and support requirements:
  - [NEEDS HUMAN INPUT: Milestone-1 data volume, workload mix and refresh overlap]
  - [NEEDS HUMAN INPUT: acceptable response time for 30 concurrent sessions]
  - [NEEDS HUMAN INPUT: pilot budget and applicability of existing dev/test guardrails]
  - [NEEDS HUMAN INPUT: tenant-native capacity administrator]
  - [NEEDS HUMAN INPUT: availability and support requirements]
- [CONFLICT NEEDS HUMAN RESOLUTION] The sandbox's relationship to the dedicated dev-subscription boundary remains unresolved.
- Resource-group absence and existing private protection are recorded from the user's statements; neither was rechecked during Stage 2.
- No completed build-readiness report was found; Terraform was unavailable in the earlier session.
