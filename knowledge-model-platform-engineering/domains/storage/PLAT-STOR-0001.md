---
id: PLAT-STOR-0001
domain: storage
type: platform-design
status: validated
owner: platform-engineering
relates_to: [PARENT-REQ-0001, PARENT-TS-0001, PARENT-DEL-0001]
source: "Platform design proposal; approved by human on 2026-08-28"
created: "2026-08-28"
tags: [adls-gen2, medallion, lifecycle]
---

## Summary
Use Azure Data Lake Storage Gen2 as independently scalable platform storage.

## Recommendation
Organize storage into bronze, silver, and gold zones. Bronze holds raw
immutable ingestion data with a 90-day hot tier and archive retention up to one
year before deletion. Silver retains curated intermediate data for 2 years.
Gold keeps reporting-ready data for 7 years in Finance and 3 years in all other
domains, consistent with regulatory or audit baselines. Use lifecycle
management, archive tiering, and a single-region baseline with a clear path to
geo-replication only if future resilience requirements demand it.

## Best-practice basis
WAF Performance Efficiency, Reliability, and Cost Optimization; CAF data
landing-zone governance; medallion architecture from the target state.

## Open items
- None. Retention, growth, and resilience inputs were supplied and validated.