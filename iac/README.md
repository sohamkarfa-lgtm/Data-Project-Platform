# Infrastructure as Code

Infrastructure code for the platform belongs here and must trace back to the approved platform design entities in [knowledge-model-platform-engineering](../knowledge-model-platform-engineering/).

The platform design child model uses [Data-Project-Knowledge-Model](https://github.com/sohamkarfa-lgtm/Data-Project-Knowledge-Model) as its parent knowledge model. Implementations should reference the relevant PLAT-* entity IDs and preserve the environment, security, networking, cost, and operations decisions recorded there.

## Deployment model

The approved platform implementation split is intentionally separated by deployment plane:

- Azure resources: azurerm and azapi Terraform providers
- Fabric control plane: Microsoft Fabric Terraform provider
- Fabric workspaces and RBAC: Fabric Terraform provider
- Fabric items: fabric-cicd or Fabric REST APIs
- Validation: JSON Schema, Terraform validation, and policy-as-code
- Secrets: workload identity/federation and Azure Key Vault
- State: protected Azure Storage remote backend

## Implementation guidance

- Keep Azure, Fabric control plane, and Fabric item deployment in separate pipeline stages.
- Store shared state in a protected remote backend and avoid local state persistence.
- Use workload identity and Key Vault rather than embedded secrets in pipeline code.
- Preserve the validated architecture decisions for subscriptions, networking, retention, Entra ID, and cost governance.
