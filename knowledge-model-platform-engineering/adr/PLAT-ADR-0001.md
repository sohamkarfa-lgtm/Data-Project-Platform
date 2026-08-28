---
id: PLAT-ADR-0001
domain: adr
type: decision
status: draft
owner: platform-engineering
relates_to: [PLAT-COMP-0001, PARENT-REQ-0001, PARENT-ADR-0002, PARENT-DEL-0004]
source: "Platform design proposal; approved by human on 2026-08-28"
created: "2026-08-28"
tags: [fabric, capacity, scaling]
---

## Context
Microsoft Fabric is the selected analytics compute direction, but workload
volume, concurrency, budget, and refresh-window inputs are not yet supplied.

## Decision
Begin with the smallest Fabric capacity tier that satisfies the agreed
Milestone 1 workload and scale capacity based on measured usage. Keep capacity
scaling independent from ADLS Gen2 storage scaling.

## Alternatives Considered
- Fixed large capacity — rejected until workload and budget data support it.
- Additional self-managed compute — rejected because managed services fit the
  small Platform Engineering team and current reporting scope.

## Consequences
This supports independent scaling and cost measurement, but final capacity
selection remains open: [NEEDS HUMAN INPUT: volume, concurrency, budget, and
refresh-window thresholds].