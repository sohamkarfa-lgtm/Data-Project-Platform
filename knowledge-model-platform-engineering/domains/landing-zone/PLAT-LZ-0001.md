---
id: PLAT-LZ-0001
domain: landing-zone
type: platform-design
status: draft
owner: platform-engineering
relates_to: [PARENT-TS-0001, PARENT-ADR-0001, PARENT-GOV-0001, PARENT-DEL-0001, PARENT-DEL-0004]
source: "Platform design proposal; approved by human on 2026-08-28"
created: "2026-08-28"
tags: [azure, fabric, landing-zone, environments]
---

## Summary
Establish an Azure and Microsoft Fabric landing zone with separate development,
test, and production boundaries and centrally owned platform services.

## Recommendation
Use separate environment resource groups and Fabric workspaces. Keep platform-
owned networking, identity, and shared services distinct from workload resources.
Apply a consistent naming and tagging convention covering environment, workload,
owner, cost center, and data classification.

## Best-practice basis
CAF landing zone management-group and subscription separation; WAF Operational
Excellence and Cost Optimization pillars.

## Open items
- [NEEDS HUMAN INPUT: Azure subscription and management-group boundaries]
- [NEEDS HUMAN INPUT: approved naming convention]
- [NEEDS HUMAN INPUT: cost-center and data-classification tags]