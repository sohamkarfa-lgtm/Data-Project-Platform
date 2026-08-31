---
id: PLAT-ADR-0003
domain: adr
type: decision
status: validated
owner: platform-engineering
relates_to: [PLAT-SEC-0001, PARENT-REQ-0004, PARENT-GOV-0001, PARENT-DEL-0004]
source: "Platform design proposal; approved by human on 2026-08-28"
created: "2026-08-28"
tags: [entra-id, rbac, security]
---

## Context
Platform access must use the existing Microsoft Entra ID identity system and
support centrally managed role-based access for a small platform team. The
validated design reuses enterprise groups where possible and creates
platform-specific admin and developer groups under central IAM ownership.

## Decision
Map Entra ID groups to least-privilege Fabric workspace and Azure resource
roles. Separate administrator, developer, operator, and consumer access, route
access changes through the existing ITSM workflow, and use managed identities
and Azure Key Vault for secrets management where supported.

## Alternatives Considered
- Separate platform identity system — rejected because it duplicates identity
  administration and conflicts with the requirement.
- Broad individual access — rejected because it violates least privilege and
  weakens operational accountability.

## Consequences
Access administration remains aligned with corporate identity governance and
uses the enterprise-approved group model. This keeps the operating model
consistent while preserving least-privilege enforcement and secure secret
handling.