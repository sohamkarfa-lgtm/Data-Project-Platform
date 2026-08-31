---
id: PLAT-ADR-0004
domain: adr
type: decision
status: validated
owner: platform-engineering
relates_to: [PLAT-LZ-0001, PLAT-COMP-0001, PLAT-STOR-0001, PLAT-NET-0001, PLAT-SEC-0001, PLAT-OPS-0001, PARENT-DEL-0001, PARENT-DEL-0003, PARENT-DEL-0004]
source: "Platform design proposal; approved by human on 2026-08-31"
created: "2026-08-31"
tags: [deployment, terraform, fabric, azure, security, state]
---

## Context
The platform spans multiple deployment planes with different control surfaces,
identity models, and lifecycle management patterns: Azure resource provisioning,
Microsoft Fabric control-plane configuration, Fabric workspace and RBAC
operations, Fabric item deployment, validation gates, secret handling, and
remote state management.

A single deployment model would mix different APIs, authentication flows, and
state semantics and would make governance and drift control harder to enforce.

## Decision
Use separate tooling for separate planes.

- Azure resources: azurerm and azapi Terraform providers
- Fabric control plane: Microsoft Fabric Terraform provider
- Fabric workspaces and RBAC: Fabric Terraform provider
- Fabric items: fabric-cicd or Fabric REST APIs
- Validation: JSON Schema, Terraform validation, and policy-as-code
- Secrets: workload identity/federation and Azure Key Vault
- State: protected Azure Storage remote backend

This split keeps each plane aligned to the toolchain that best matches its
provider model, security boundary, and operational lifecycle.

## Alternatives Considered
- Single end-to-end deployment tooling for all layers — rejected because Azure,
  Fabric control plane, and Fabric item deployment do not share the same API,
  identity model, or change semantics.
- Script-heavy deployment for Fabric items — rejected because it weakens
  repeatability, reviewability, and auditability compared with provider-based
  and REST-based automation.
- Centralized secret storage in application code or local environment variables
  — rejected because it conflicts with secure automation and workload identity
  best practice.

## Consequences
This approach creates a clearer deployment topology and better separation of
concerns across Azure, Fabric, and platform operations. It also improves
observability, validation, and governance, but requires distinct pipeline
stages and role boundaries for each plane.
