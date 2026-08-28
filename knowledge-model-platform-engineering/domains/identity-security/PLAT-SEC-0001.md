---
id: PLAT-SEC-0001
domain: identity-security
type: platform-design
status: draft
owner: platform-engineering
relates_to: [PARENT-REQ-0004, PARENT-GOV-0001, PARENT-TS-0001, PARENT-DEL-0004]
source: "Platform design proposal; approved by human on 2026-08-28"
created: "2026-08-28"
tags: [entra-id, rbac, key-vault, encryption]
---

## Summary
Integrate platform authentication and authorization with Microsoft Entra ID.

## Recommendation
Map existing Entra ID groups to least-privilege workspace and resource roles.
Separate platform administrators, developers, operators, and consumers. Use
managed identities where supported, store secrets in approved secret management,
and require encryption in transit and at rest.

## Best-practice basis
WAF Security least-privilege RBAC, managed identities, and encryption; CAF
identity and access-management baseline.

## Open items
- [NEEDS HUMAN INPUT: existing Entra ID groups and owners]
- [NEEDS HUMAN INPUT: role-to-group mapping]
- [NEEDS HUMAN INPUT: secrets rotation policy]
- [NEEDS HUMAN INPUT: compliance requirements]