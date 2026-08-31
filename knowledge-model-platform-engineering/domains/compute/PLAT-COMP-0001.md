---
id: PLAT-COMP-0001
domain: compute
type: platform-design
status: validated
owner: platform-engineering
relates_to: [PARENT-REQ-0001, PARENT-TS-0001, PARENT-ADR-0002, PARENT-DEL-0004]
source: "Platform design proposal; approved by human on 2026-08-31"
created: "2026-08-28"
tags: [fabric, capacity, scaling, workspaces]
---

## Summary
Use Microsoft Fabric capacity as the analytics compute layer with independently
scalable capacity and ADLS Gen2 storage.

## Recommendation
Start with a smaller Fabric capacity tier sized to the Milestone 1 profile and
scale using observed workload, concurrency, and refresh-window metrics. Keep
separate development, test, and production workspaces and use controlled
promotion. Apply the validated budget guardrail of $10,000-$14,000/month for
Fabric plus adjacent services, with dev/test capped separately at
$2,000/month and an 80%-of-ceiling Finance alert.

## Best-practice basis
WAF Performance Efficiency and Cost Optimization through measured right-sizing;
CAF workload and environment separation.

## Open items
- None. Capacity sizing and budget inputs were supplied and validated.