---
id: PLAT-STOR-0001
domain: storage
type: platform-design
status: draft
owner: platform-engineering
relates_to: [PARENT-REQ-0001, PARENT-TS-0001, PARENT-DEL-0001]
source: "Platform design proposal; approved by human on 2026-08-28"
created: "2026-08-28"
tags: [adls-gen2, medallion, lifecycle]
---

## Summary
Use Azure Data Lake Storage Gen2 as independently scalable platform storage.

## Recommendation
Organize storage into bronze, silver, and gold zones. Keep raw ingestion
immutable where practical, apply lifecycle policies to aged data, and retain
curated data according to agreed reporting and regulatory needs. Select the
redundancy tier after recovery requirements are confirmed.

## Best-practice basis
WAF Performance Efficiency and Cost Optimization; CAF data landing-zone
governance; medallion architecture from the target state.

## Open items
- [NEEDS HUMAN INPUT: expected data volume and growth rate]
- [NEEDS HUMAN INPUT: retention periods]
- [NEEDS HUMAN INPUT: recovery point and recovery time objectives]
- [NEEDS HUMAN INPUT: redundancy and geo-replication requirement]