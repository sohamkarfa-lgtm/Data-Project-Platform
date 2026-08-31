---
id: PLAT-NET-0001
domain: network
type: platform-design
status: validated
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
Use a dedicated peered spoke VNet inside the existing hub-spoke model. Keep the
platform private-by-default, with private endpoints for sensitive services and
centrally managed private DNS zones under the network team’s governance. Use
the existing ExpressRoute circuit for on-premises coexistence and restrict all
public access to explicitly approved exceptions only.

## Best-practice basis
CAF network topology and private connectivity patterns; WAF Security defense in
depth.

## Open items
- None. Existing topology, connectivity method, and approval posture were supplied and validated.