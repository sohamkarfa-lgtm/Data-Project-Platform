# Data Project Platform

This repository contains the platform engineering design, generated platform specification, and Terraform boilerplate for the Data and Analytics modernization engagement.

The intended flow is:

1. Capture validated design intent in `knowledge-model-platform-engineering/`.
2. Generate a machine-readable contract in `platform-spec/`.
3. Use the spec to fill or update the deployable Terraform boilerplate in `iac/`.

Platform infrastructure requests enter through the
[Fabric Platform Development Kit](fabric_platform_development_kit/README.md),
which orchestrates this flow through seven approval-gated stages. Resume the
relevant run from its manifest, or start Stage 1 if no relevant run exists.

## Request Opening

Use this opening for individual platform change requests:

```text
Use fabric_platform_development_kit to process this request.
Treat "provision" as the desired outcome, not authorization for
direct cloud execution.

Resume the relevant run from its manifest; otherwise start Stage 1.
Follow each stage's approval gate and preserve the existing project
structure. Start by reporting the run ID, active stage and permitted
actions.

Requirement:
<client, environment, scope, sizing inputs and entity references>
```

The root [AGENTS.md](AGENTS.md) applies this routing even when a request does
not name the kit. A stage approval applies to that stage only. The kit produces
a deployment-readiness package; live deployment is a separate human action
after readiness approval. Azure CLI, REST, SDK and portal actions must not be
used to bypass this boundary.

## Repository Relationship

The platform model is a child knowledge model of [Data-Project-Knowledge-Model](https://github.com/sohamkarfa-lgtm/Data-Project-Knowledge-Model). The parent repository remains the source of enterprise context, requirements, target-state architecture, governance, delivery milestones, and architecture decisions.

This repository links back to parent entities with `PARENT-*` IDs and keeps its own `PLAT-*` registry in [knowledge-model-platform-engineering/entities.index.yaml](knowledge-model-platform-engineering/entities.index.yaml).

## Repository Structure

```text
/
  AGENTS.md
  fabric_platform_development_kit/
    AGENTS.md
    README.md
    workflow.yaml
    config/
    stages/
    templates/
    runs/
  iac/
    AGENTS.md
    modules/
      azure-landing-zone/
      storage/
      networking/
      key-vault/
      fabric-capacity/
      fabric-workspace/
      fabric-rbac/
      monitoring/
    environments/
      dev/
      test/
      prod/
    PLATFORM_SPEC_MAPPING.md
    README.md
  knowledge-model-platform-engineering/
    AGENTS.md
    domains/
      landing-zone/
      compute/
      storage/
      network/
      identity-security/
      operations/
    adr/
    prompt-library/
    entities.index.yaml
  open-questions/
    oq_ans/
  platform-spec/
    organization.yaml
    environments/
      dev.yaml
      test.yaml
      prod.yaml
```

## Agent Guidance

`AGENTS.md` files are not required for the project to build, but they are useful
for keeping coding-agent work consistent. This repository uses four instruction
files:

- [AGENTS.md](AGENTS.md) for repository-wide source-of-truth and workflow rules.
- [knowledge-model-platform-engineering/AGENTS.md](knowledge-model-platform-engineering/AGENTS.md) for design entities, ADRs, approval status, and registry updates.
- [iac/AGENTS.md](iac/AGENTS.md) for Azure, Microsoft Fabric, and Terraform implementation rules.
- [fabric_platform_development_kit/AGENTS.md](fabric_platform_development_kit/AGENTS.md) for sequential stages, permitted actions, and approval bookkeeping.

No separate `platform-spec/AGENTS.md` is currently needed because `platform-spec/`
is generated contract data governed by the root workflow. Add more nested
instruction files only when a subdirectory has distinct build, validation,
approval, or ownership rules.

## Knowledge Model

The platform knowledge model records the validated design source of truth:

- Landing zone: development, test, and production boundaries
- Compute: Microsoft Fabric capacity and workspace model
- Storage: ADLS Gen2 bronze/silver/gold layout and retention posture
- Network: private-by-default hub-spoke connectivity with ExpressRoute coexistence
- Identity and security: Microsoft Entra ID, group-based RBAC, managed identities, and Key Vault
- Operations: cost visibility, budget alerts, monitoring, and CI/CD governance

The current validated assumptions include:

- Approximately 800 GB initial Milestone 1 load
- Approximately 150 peak concurrent reporting sessions
- $10,000-$14,000 per month for Fabric plus adjacent services
- Dev/test spend capped separately at $2,000 per month
- One regulated Finance domain with a 7-year gold retention baseline

## Platform Spec

`platform-spec/` is a generated, environment-scoped YAML contract derived from the validated `PLAT-*` entities and approved answer files.

- [platform-spec/organization.yaml](platform-spec/organization.yaml) captures shared organization-level settings.
- [platform-spec/environments/dev.yaml](platform-spec/environments/dev.yaml), [test.yaml](platform-spec/environments/test.yaml), and [prod.yaml](platform-spec/environments/prod.yaml) capture environment-specific platform values.
- Unresolved design-to-build inputs are intentionally left as `[NEEDS HUMAN INPUT: ...]` markers.

The spec is not the source of truth for design decisions; it is the deployable contract generated from that source of truth.

## Infrastructure As Code

`iac/` contains a Terraform scaffold for the Azure + Microsoft Fabric platform:

- Azure resource groups and optional management group association
- Spoke virtual network, subnets, optional private DNS zones, and optional hub peering
- ADLS Gen2 storage account with bronze/silver/gold containers and lifecycle rules
- RBAC-enabled Azure Key Vault with optional private endpoint
- Microsoft Fabric capacity as an Azure resource
- Microsoft Fabric workspaces and workspace RBAC assignments
- Log Analytics, diagnostics, alerts, and optional subscription budget

Use [iac/PLATFORM_SPEC_MAPPING.md](iac/PLATFORM_SPEC_MAPPING.md) when converting `platform-spec/` YAML into `terraform.tfvars` or HCL updates.

## Deployment Starting Point

Each environment folder contains a root Terraform configuration plus examples:

- `backend.tf.example` for remote state configuration
- `terraform.tfvars.example` for environment inputs

After Stage 7 readiness approval, the human deployment operator replaces the
example values and uses the following starting workflow outside the kit:

```powershell
cd iac/environments/dev
Copy-Item backend.tf.example backend.tf
Copy-Item terraform.tfvars.example terraform.tfvars
terraform init
terraform plan -var-file terraform.tfvars
```

Replace example values before running `apply`, especially subscription IDs, tenant ID, region, private DNS zone IDs, Fabric capacity SKU, capacity administrators, Entra principal IDs, budget contacts, and remote-state settings.

## Change Workflow

1. Enter or resume the kit run using [workflow.yaml](fabric_platform_development_kit/workflow.yaml) and its manifest. Follow stage-specific read/write permissions and approval gates.
2. Complete Requirement Analysis, Current State Assessment, Gap Analysis, and Solution Design in order, with approval at each boundary.
3. If design entities need changes, use the approval-gated prompts in `knowledge-model-platform-engineering/prompt-library/` through the kit; preserve their own gates.
4. In Stage 5, propose the contract and Terraform changes using the approved design and spec mapping. Write only approved file contents within the approved scope, preferring existing files.
5. Complete Stage 6 validation and Stage 7 deployment-readiness review. Keep missing inputs and failed checks explicit; the kit does not run real-credential plan/apply or other cloud mutations.
6. After readiness approval, hand off deployment to the human operator following [iac/README.md](iac/README.md).
7. Keep changes traceable to the run's approved artifacts and `PLAT-*` / `PLAT-ADR-*` entity IDs.

See [knowledge-model-platform-engineering/README.md](knowledge-model-platform-engineering/README.md) for the domain conventions and [iac/README.md](iac/README.md) for Terraform implementation details.
