---
id: PLAT-ADR-0002
domain: adr
type: decision
status: draft
owner: platform-engineering
relates_to: [PLAT-LZ-0001, PLAT-NET-0001, PARENT-ADR-0001, PARENT-REQ-0003, PARENT-DEL-0001]
source: "Platform design proposal; approved by human on 2026-08-28"
created: "2026-08-28"
tags: [network, private-access, coexistence]
---

## Context
The modernized Supply Chain flow must run in parallel with the existing
on-premises mart until it is proven, while platform services require protected
connectivity.

## Decision
Adopt private-by-default access with private endpoints for sensitive services,
central private DNS, and approved secure connectivity to on-premises systems.
Public access requires an explicitly documented exception.

## Alternatives Considered
- Public service endpoints — rejected as the default because they weaken the
  security boundary.
- Big-bang network migration — rejected because coexistence is required.

## Consequences
The design supports defense in depth and parallel operation but depends on
[NEEDS HUMAN INPUT: existing hub, firewall, DNS, and on-premises connectivity
standards].