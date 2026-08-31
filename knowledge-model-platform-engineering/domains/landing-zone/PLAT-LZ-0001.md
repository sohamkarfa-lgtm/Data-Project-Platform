---
id: PLAT-LZ-0001
domain: landing-zone
type: platform-design
status: validated
owner: platform-engineering
relates_to: [PARENT-TS-0001, PARENT-ADR-0001, PARENT-GOV-0001, PARENT-DEL-0001, PARENT-DEL-0004]
source: "Platform design proposal; approved by human on 2026-08-31"
created: "2026-08-28"
tags: [azure, fabric, landing-zone, environments]
---

## Summary
Establish an Azure and Microsoft Fabric landing zone with separate development,
test, and production boundaries and centrally owned platform services.

## Recommendation
Use a dedicated Data-Analytics management group with separate dev, test, and
prod subscriptions. Keep platform-owned networking, identity, and shared
services in a distinct control plane from workload resources, with a 1:1
mapping between workload and environment boundary. Apply a standard naming and
tagging model covering environment, workload, cost center, and data
classification.

## Best-practice basis
CAF landing zone management-group and subscription separation; WAF Operational
Excellence and Cost Optimization pillars.

## Open items
- None. All required landing-zone inputs were supplied and validated.