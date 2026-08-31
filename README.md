# Data Project Platform

This repository contains the platform engineering design, generated platform specification, and Terraform boilerplate for the Data and Analytics modernization engagement.

The intended flow is:

1. Capture validated design intent in `knowledge-model-platform-engineering/`.
2. Generate a machine-readable contract in `platform-spec/`.
3. Use the spec to fill or update the deployable Terraform boilerplate in `iac/`.

## Repository Relationship

The platform model is a child knowledge model of [Data-Project-Knowledge-Model](https://github.com/sohamkarfa-lgtm/Data-Project-Knowledge-Model). The parent repository remains the source of enterprise context, requirements, target-state architecture, governance, delivery milestones, and architecture decisions.

This repository links back to parent entities with `PARENT-*` IDs and keeps its own `PLAT-*` registry in [knowledge-model-platform-engineering/entities.index.yaml](knowledge-model-platform-engineering/entities.index.yaml).

## Repository Structure

```text
/
  iac/
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

Typical workflow:

```powershell
cd iac/environments/dev
Copy-Item backend.tf.example backend.tf
Copy-Item terraform.tfvars.example terraform.tfvars
terraform init
terraform plan -var-file terraform.tfvars
```

Replace example values before running `apply`, especially subscription IDs, tenant ID, region, private DNS zone IDs, Fabric capacity SKU, capacity administrators, Entra principal IDs, budget contacts, and remote-state settings.

## Change Workflow

1. Update the knowledge model only through the approval-gated prompts in `knowledge-model-platform-engineering/prompt-library/`.
2. Regenerate `platform-spec/` from validated entities and approved answer files.
3. Review spec changes before writing them.
4. Use the spec mapping to update environment variables or Terraform configuration.
5. Run Terraform formatting, validation, and plan in the target environment.
6. Keep implementation changes traceable to `PLAT-*` and `PLAT-ADR-*` entity IDs.

See [knowledge-model-platform-engineering/README.md](knowledge-model-platform-engineering/README.md) for the domain conventions and [iac/README.md](iac/README.md) for Terraform implementation details.
