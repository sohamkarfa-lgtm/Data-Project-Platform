---
id: PLAT-ADR-0002
domain: adr
type: decision
status: validated
owner: platform-engineering
relates_to: [PLAT-LZ-0001, PLAT-NET-0001, PARENT-ADR-0001, PARENT-REQ-0003, PARENT-DEL-0001]
source: "Platform design proposal; approved by human on 2026-08-28"
created: "2026-08-28"
tags: [network, private-access, coexistence]
---

## Context
The modernized Supply Chain flow must run in parallel with the existing
on-premises mart until it is proven, while platform services require protected
connectivity. The validated design baseline assumes a hub-spoke topology, a
new peered spoke VNet, centrally managed private DNS, and ExpressRoute-based
on-premises coexistence.

## Decision
Adopt private-by-default access with private endpoints for sensitive services,
central private DNS managed by the network team, and the existing ExpressRoute
circuit for on-premises data flows. Public access is restricted to explicitly
approved exceptions only.

## Alternatives Considered
- Public service endpoints — rejected as the default because they weaken the
  security boundary.
- Big-bang network migration — rejected because coexistence is required.

## Consequences
The design supports defense in depth and parallel operation while aligning with
existing enterprise network standards and coexistence requirements. It keeps the
platform secure by default without disrupting the existing on-premises mart.