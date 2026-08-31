---
id: PLAT-SEC-0001
domain: identity-security
type: platform-design
status: validated
owner: platform-engineering
relates_to: [PARENT-REQ-0004, PARENT-GOV-0001, PARENT-TS-0001, PARENT-DEL-0004]
source: "Platform design proposal; approved by human on 2026-08-28"
created: "2026-08-28"
tags: [entra-id, rbac, key-vault, encryption]
---

## Summary
Integrate platform authentication and authorization with Microsoft Entra ID.

## Recommendation
Use Microsoft Entra ID as the identity provider and reuse existing enterprise
groups where possible while creating platform-specific admin and developer
roles. Apply group-based least-privilege RBAC across Fabric workspaces and
Azure resources, with access-change approvals routed through the existing
ITSM/ServiceNow workflow. Use managed identities where supported, Azure Key
Vault for secrets, and encryption in transit and at rest by default. Keep
recurring access reviews and regulated-domain controls aligned to the
enterprise compliance baseline.

## Best-practice basis
WAF Security least-privilege RBAC, managed identities, and encryption; CAF
identity and access-management baseline.

## Open items
- None. Existing Entra ID groups, role mapping, and secret-management posture were supplied and validated.