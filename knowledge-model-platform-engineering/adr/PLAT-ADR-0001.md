---
id: PLAT-ADR-0001
domain: adr
type: decision
status: validated
owner: platform-engineering
relates_to: [PLAT-COMP-0001, PARENT-REQ-0001, PARENT-ADR-0002, PARENT-DEL-0004]
source: "Platform design proposal; approved by human on 2026-08-28"
created: "2026-08-28"
tags: [fabric, capacity, scaling]
---

## Context
Microsoft Fabric is the selected analytics compute direction. The validated
Milestone 1 workload profile is ~800 GB initial load, ~150 peak concurrent
sessions, nightly batch windows with hourly Supply Chain refreshes, and a
$10,000-$14,000 monthly cost ceiling for Fabric and adjacent services.

## Decision
Start with a smaller Fabric capacity tier sized to the Milestone 1 workload and
scale based on measured usage, concurrency, and refresh-window data. Keep
capacity scaling independent from ADLS Gen2 storage scaling and apply the
validated budget guardrail of $10,000-$14,000/month, with dev/test capped at
$2,000/month and an 80%-of-ceiling Finance alert.

## Alternatives Considered
- Fixed large capacity — rejected because the validated profile does not justify
  a full-size commitment at launch.
- Additional self-managed compute — rejected because managed services fit the
  small Platform Engineering team and current reporting scope.

## Consequences
This supports independent scaling and cost measurement while keeping the
platform inside the approved operating budget. The design remains intentionally
incremental and can be expanded only as workload and cost telemetry support it.