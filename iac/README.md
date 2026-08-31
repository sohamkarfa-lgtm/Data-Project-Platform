# Infrastructure as Code

Infrastructure code for the platform belongs here and must trace back to the approved platform design entities in [knowledge-model-platform-engineering](../knowledge-model-platform-engineering/).

This folder contains a deployable Terraform boilerplate for the Microsoft Azure + Microsoft Fabric data platform. It is intentionally parameterized so generated `platform-spec/` YAML can later be translated into environment `*.tfvars` or direct HCL updates by prompt.

## Structure

```text
iac/
  modules/
    azure-landing-zone/  Resource groups and optional management-group association
    storage/             ADLS Gen2 storage account, medallion containers, lifecycle, private endpoints
    networking/          Spoke VNet, subnets, optional private DNS zones, optional hub peering
    key-vault/           RBAC-enabled Key Vault and optional private endpoint
    fabric-capacity/     Azure Fabric capacity resource
    fabric-workspace/    Microsoft Fabric workspaces
    fabric-rbac/         Microsoft Fabric workspace role assignments
    monitoring/          Log Analytics, diagnostics, alerts, and optional budget
  environments/
    dev/
    test/
    prod/
```

## Deployment model

The approved platform implementation split is intentionally separated by deployment plane:

- Azure resources: `azurerm`
- Fabric capacity as an Azure resource: `azurerm_fabric_capacity`
- Fabric control plane, workspaces, and RBAC: `microsoft/fabric`
- Fabric items: `fabric-cicd` or Fabric REST APIs, to be added after workspace foundation
- Secrets: workload identity/federation and Azure Key Vault
- State: protected Azure Storage remote backend

## Basic Workflow

1. Fill an environment `terraform.tfvars` from `terraform.tfvars.example`.
2. Copy `backend.tf.example` to `backend.tf` and point it at the approved remote-state account.
3. Authenticate to Azure and Microsoft Fabric with an identity that can create Azure resources and manage Fabric workspaces.
4. Run from the target environment folder:

```powershell
terraform init
terraform plan -var-file terraform.tfvars
terraform apply -var-file terraform.tfvars
```

The Fabric provider needs permission to see the Fabric capacity before assigning workspaces to it. If the data source cannot resolve a newly created capacity during the same run, set `fabric_capacity_id_override` to the Fabric capacity GUID and re-run.

## Spec Mapping

Use [PLATFORM_SPEC_MAPPING.md](PLATFORM_SPEC_MAPPING.md) when generating or refreshing `terraform.tfvars` from the `platform-spec/` YAML tree.

## Implementation Guidance

- Keep Azure, Fabric control plane, and Fabric item deployment in separate pipeline stages.
- Store shared state in a protected remote backend and avoid local state persistence.
- Use workload identity and Key Vault rather than embedded secrets in pipeline code.
- Preserve the validated architecture decisions for subscriptions, networking, retention, Entra ID, and cost governance.

## Verification Notes

Provider and resource shapes were checked against current documentation for:

- Fabric capacity: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/fabric_capacity
- Fabric workspace: https://registry.terraform.io/providers/microsoft/fabric/latest/docs/resources/workspace
- Fabric workspace RBAC: https://registry.terraform.io/providers/microsoft/fabric/latest/docs/resources/workspace_role_assignment
- Microsoft Fabric capacities ARM/Terraform AzAPI reference: https://learn.microsoft.com/en-us/azure/templates/microsoft.fabric/capacities

`terraform` and `tofu` were not installed in the shell used to scaffold this repository, so `terraform fmt` and `terraform validate` could not be run there. Static checks were run for expected files, balanced braces, and unresolved `var.*`, `local.*`, and `module.*` references.
