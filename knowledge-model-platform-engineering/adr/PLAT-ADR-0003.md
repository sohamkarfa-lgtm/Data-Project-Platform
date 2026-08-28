---
id: PLAT-ADR-0003
domain: adr
type: decision
status: draft
owner: platform-engineering
relates_to: [PLAT-SEC-0001, PARENT-REQ-0004, PARENT-GOV-0001, PARENT-DEL-0004]
source: "Platform design proposal; approved by human on 2026-08-28"
created: "2026-08-28"
tags: [entra-id, rbac, security]
---

## Context
Platform access must use the existing Microsoft Entra ID identity system and
support centrally managed role-based access for a small platform team.

## Decision
Map Entra ID groups to least-privilege Fabric workspace and Azure resource
roles. Separate administrator, developer, operator, and consumer access, and
use managed identities and approved secret management where supported.

## Alternatives Considered
- Separate platform identity system — rejected because it duplicates identity
  administration and conflicts with the requirement.
- Broad individual access — rejected because it violates least privilege and
  weakens operational accountability.

## Consequences
Access administration remains aligned with corporate identity governance, but
the final mapping depends on [NEEDS HUMAN INPUT: group ownership, role mapping,
and secrets rotation policy].