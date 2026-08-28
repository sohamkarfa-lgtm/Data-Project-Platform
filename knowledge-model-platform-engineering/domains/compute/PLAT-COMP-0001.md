---
id: PLAT-COMP-0001
domain: compute
type: platform-design
status: draft
owner: platform-engineering
relates_to: [PARENT-REQ-0001, PARENT-TS-0001, PARENT-ADR-0002, PARENT-DEL-0004]
source: "Platform design proposal; approved by human on 2026-08-28"
created: "2026-08-28"
tags: [fabric, capacity, scaling, workspaces]
---

## Summary
Use Microsoft Fabric capacity as the analytics compute layer with independently
scalable capacity and ADLS Gen2 storage.

## Recommendation
Start with the smallest capacity tier that satisfies the agreed Milestone 1
workload. Scale using observed workload, refresh-window, and concurrency metrics.
Use separate development, test, and production workspaces with controlled
promotion.

## Best-practice basis
WAF Performance Efficiency and Cost Optimization through measured right-sizing;
CAF workload and environment separation.

## Open items
- [NEEDS HUMAN INPUT: expected data volume]
- [NEEDS HUMAN INPUT: concurrent user count]
- [NEEDS HUMAN INPUT: workload concurrency and refresh windows]
- [NEEDS HUMAN INPUT: Milestone 1 capacity budget]