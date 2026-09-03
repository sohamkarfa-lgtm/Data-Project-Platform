# AGENTS.md

## Scope

These instructions apply to Terraform implementation under `iac/`. The code
deploys Azure resources, Microsoft Fabric capacity, Fabric workspaces, workspace
RBAC, storage, networking, Key Vault, and monitoring.

## Terraform Practices

- Check whether Terraform is available with `terraform version` before relying on
  Terraform commands in a session. If it is missing on Windows, suggest
  `winget install Hashicorp.Terraform`.
- Follow HashiCorp Terraform language style for formatting, naming, locals,
  variables, outputs, and module structure.
- Keep AzureRM on the current major version already used by the repo unless the
  user requests a provider upgrade. This repo currently requires `azurerm`
  `>= 4.16.0, < 5.0.0`.
- Prefer official provider documentation for uncertain AzureRM or Fabric resource
  arguments.
- Keep modules reusable and environment roots thin. Put shared behavior in
  `iac/modules/*` and environment-specific composition in
  `iac/environments/<env>/`.

## Source Mapping

- Use `iac/PLATFORM_SPEC_MAPPING.md` when translating `platform-spec/` YAML to
  Terraform variables or HCL.
- Preserve the deployment-plane split from `iac/README.md`: Azure resources via
  `azurerm`, Fabric control-plane resources via `microsoft/fabric`, and Fabric
  items through later Fabric CI/CD or REST stages.
- Resolve display names to required IDs before writing RBAC or capacity inputs.
  Do not guess Entra principal IDs, tenant IDs, subscription IDs, private DNS zone
  IDs, or Fabric capacity GUIDs.

## Security And State

- Never commit `terraform.tfstate`, `.terraform/`, generated plan files, populated
  `backend.tf`, or populated `terraform.tfvars`.
- Keep `backend.tf.example` and `terraform.tfvars.example` safe for source control.
- Use workload identity, managed identities, and Key Vault patterns instead of
  embedding secrets in Terraform or pipeline code.
- Keep private-network defaults intact unless the approved platform spec explicitly
  changes the posture.

## Verification

- After Terraform edits, run `terraform fmt -recursive` from `iac/` when Terraform
  is available.
- Run `terraform validate` from each affected environment folder before any plan.
- Run `terraform plan -var-file terraform.tfvars` only when real local inputs are
  available and the user expects a deployability check.
- Do not run `terraform apply` unless the user explicitly asks for deployment and
  approvals are clear.
