---
id: PLAT-NET-0001
domain: network
type: platform-design
status: draft
owner: platform-engineering
relates_to: [PARENT-ADR-0001, PARENT-TS-0001, PARENT-REQ-0003, PARENT-GOV-0001, PARENT-DEL-0004]
source: "Platform design proposal; approved by human on 2026-08-28"
created: "2026-08-28"
tags: [private-access, connectivity, coexistence]
---

## Summary
Provide private-by-default platform connectivity while preserving secure access
to on-premises systems during incremental coexistence.

## Recommendation
Use private endpoints for ADLS Gen2 and other sensitive dependencies where
supported. Restrict public network access, apply subnet and service-boundary
security controls, and centrally manage private DNS zones. Use approved secure
connectivity for on-premises data flows.

## Best-practice basis
CAF network topology and private connectivity patterns; WAF Security defense in
depth.

## Open items
- [NEEDS HUMAN INPUT: existing Azure virtual network and hub connectivity]
- [NEEDS HUMAN INPUT: on-premises connectivity method]
- [NEEDS HUMAN INPUT: approved egress and firewall policy]
- [NEEDS HUMAN INPUT: public-access exceptions]