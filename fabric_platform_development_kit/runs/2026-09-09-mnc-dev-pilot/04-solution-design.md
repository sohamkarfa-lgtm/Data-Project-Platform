---
run_id: "2026-09-09-mnc-dev-pilot"
stage: solution-design
status: approved
approved_by: "User (explicit approval of revised Stage 4 scope)"
approved_at: "2026-09-09"
created: "2026-09-09"
---

## Design proposal
| Gaps | Proposed design | Basis |
|---|---|---|
| G1-G4 | One F2 capacity named mncm1devfabric, one workspace named mnc-milestone1-dev, and resource group rg-mnc-milestone1-dev-se, all targeting North Europe. Names approved with this design. | PLAT-COMP-0001, PLAT-LZ-0001, PLAT-ADR-0001 |
| G5 | Adapt the existing iac/environments/dev root to this pilot, containing only resource-group, capacity and workspace composition. Disable workspace identity creation and subscription reassociation. Keep existing shared resource modules and test/prod roots. | CAF environment separation; minimal change scope |
| G6 | Consume existing private-access protection confirmed by user. Record verification evidence before readiness; create no networking controls. | PLAT-NET-0001; WAF Security |
| G7-G9 | Blocked: retain workload, response-time, budget, availability and support markers. F2 is the selected baseline, without a performance guarantee. | WAF Performance Efficiency and Cost Optimization |
| G10 | Blocked: preserve sandbox/dev-subscription conflict. No governance exception assumed. | PLAT-LZ-0001 |
| G11 | Blocked: require tenant-native capacity administrator through local deployment inputs. | Existing access dependency |
| G12 | Validate Terraform and source traceability, then produce kit deployment-readiness package. | PLAT-ADR-0004 |

## Architecture updates
No validated entity changes proposed now. A sandbox exception, if needed, requires its own design-decision approval.

## Deployment strategy
Dev only. After approved kit handoff: resource group, capacity, resolve Fabric capacity GUID, assigned workspace. Before deployment verify resource-group absence and existing privacy coverage. Validation failures stop handoff. Repository rollback is limited to this run's changes. No automatic cloud deletion proposed.

## Modular task breakdown
| Task | Target | Gaps |
|---|---|---|
| Update the existing dev contract for this pilot and explicitly record excluded provisioning | platform-spec/environments/dev.yaml | G1-G4, G6-G11 |
| Adapt existing dev composition, locals, variables, providers, outputs and safe examples; remove references to excluded services from the dev root | iac/environments/dev/main.tf, iac/environments/dev/locals.tf, iac/environments/dev/variables.tf, iac/environments/dev/providers.tf, iac/environments/dev/versions.tf, iac/environments/dev/outputs.tf, iac/environments/dev/terraform.tfvars.example, iac/environments/dev/backend.tf.example | G1-G6, G11-G12 |
| Declare Fabric provider source within the existing workspace module file | iac/modules/fabric-workspace/main.tf | G2, G12 |
| Update existing dev workflow and contract mapping documentation | README.md, iac/README.md, iac/PLATFORM_SPEC_MAPPING.md | G1-G12 |

Task dependencies: contract precedes root; provider declaration precedes validation; documentation covers the complete composition. The user requested preserving the project structure after the original Stage 4 approval and explicitly approved this revised scope. This revision supersedes the proposed new pilot folder, separate contract and new provider file. All implementation targets above already exist. The required kit run folder already exists and remains the approval record. Kit governance files are not changed. Stage 5 may now present corresponding diffs under its own content approval gate.

The revised in-place design is explicitly approved; Stage 5 file contents require their own approval. Existing dev configuration becomes pilot-specific. Before any post-kit deployment, confirm that the selected backend/state does not manage excluded resources; a plan proposing their destruction is a blocker, not an approved cleanup action.

## Validation strategy
- Confirm F2, northeurope, exact resource-group name and exactly one workspace.
- Confirm no excluded resources or workspace identity are created.
- Confirm that test/prod roots and shared resource behavior remain intact; verify the shared provider declaration in affected roots.
- Check provider resolution, Terraform formatting/validation and capacity GUID assignment.
- Keep unresolved inputs, privacy evidence and governance conflict visible as readiness blockers.
- Leave real-credential plan/apply to post-kit deployment handoff.

## Explicit reuse check
Existing iac/modules/azure-landing-zone, fabric-capacity and fabric-workspace cover resource behavior. No new resource module proposed. Subscription, administrator, backend and required tag values remain explicit inputs.

## Residual inputs
- [NEEDS HUMAN INPUT: Milestone-1 data volume, workload mix and refresh overlap]
- [NEEDS HUMAN INPUT: acceptable response time for 30 concurrent sessions]
- [NEEDS HUMAN INPUT: pilot budget and applicability of existing dev/test guardrails]
- [NEEDS HUMAN INPUT: tenant-native capacity administrator]
- [NEEDS HUMAN INPUT: availability and support requirements]
- [CONFLICT NEEDS HUMAN RESOLUTION] Sandbox alignment with the dedicated dev-subscription boundary.
