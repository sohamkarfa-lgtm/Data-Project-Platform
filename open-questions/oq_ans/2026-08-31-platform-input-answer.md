# Platform Input Answers — 2026-08-31

**Status:**  Sourced from any stakeholder, transcript, or
evidence entity.

**Assumed profile:** 4–5 source systems, ~150 peak concurrent business users,
single-region deployment, one regulated domain (Finance).

**Source questionnaire:** `open-questions/2026-08-31-platform-input-questionnaire.md`
(Prompt 01 — Platform Input Questionnaire)

---

## Answers

### 1. Milestone 1 data volume and growth rate
**Category:** SIZING / VOLUME
**Unblocks:** PLAT-COMP-0001, PLAT-STOR-0001, PLAT-ADR-0001

~800 GB initial load across ERP, CRM, Supply Chain, and Finance source
systems (~120 tables in scope for Milestone 1). ~25% year-over-year growth
expected as additional marts migrate onto the platform.

**Basis:** Mid-sized org profile with a single transactional core system
(~1,000 tables), where Milestone 1 covers a defined subset rather than the
full estate.

---

### 2. Concurrent users and peak concurrency
**Category:** SIZING / VOLUME
**Unblocks:** PLAT-COMP-0001, PLAT-ADR-0001

~120 named users; ~150 peak concurrent sessions during month-end close and
morning reporting hours (8–10am local).

**Basis:** Consistent with a single central data team serving four business
units — not yet an enterprise-wide self-service rollout.

---

### 3. Refresh windows, SLAs, and concurrency thresholds
**Category:** SIZING / VOLUME
**Unblocks:** PLAT-COMP-0001, PLAT-ADR-0001

Nightly batch complete by 6:00 AM local for standard reporting (99.5%
on-time SLA). Supply Chain inventory refreshed approximately hourly (95%
on-time SLA). Platform must sustain ~150 concurrent report sessions without
material query degradation.

**Basis:** Matches the stated hourly Supply Chain need and the
nightly-is-sufficient posture for the other three marts.

---

### 4. Milestone 1 budget ceiling
**Category:** BUDGET / COST
**Unblocks:** PLAT-COMP-0001, PLAT-ADR-0001

$10,000–14,000/month for Fabric capacity plus adjacent services (ADLS, ADF,
monitoring). Dev/test capped separately at $2,000/month. An 80%-of-ceiling
threshold triggers a Finance alert.

**Basis:** Typical starting range for an F32–F64-class Fabric capacity tier
at the volume and concurrency assumed above.

---

### 5. Azure subscription and management-group boundaries
**Category:** OWNERSHIP / GOVERNANCE
**Unblocks:** PLAT-LZ-0001

A dedicated "Data-Analytics" management group under the existing enterprise
root. Separate subscriptions for dev, test, and prod. Workloads map 1:1 to
environment — no shared prod/non-prod resources.

**Basis:** Standard Cloud Adoption Framework landing-zone separation for a
platform team bootstrapping inside an existing enterprise estate.

---

### 6. Retention periods (bronze / silver / gold)
**Category:** COMPLIANCE / REGULATORY
**Unblocks:** PLAT-STOR-0001

Bronze: 90 days hot, then archive tier for 1 year, then delete. Silver: 2
years. Gold: 7 years for Finance-touching data (regulatory/audit baseline),
3 years for all other domains.

**Basis:** 7-year figure reflects a common Finance book-closing/audit
retention baseline; shorter tiers apply to non-regulated domains.

---

### 7. Existing network topology and standards
**Category:** EXISTING INFRASTRUCTURE / STANDARDS
**Unblocks:** PLAT-NET-0001, PLAT-ADR-0002

A hub-spoke topology already exists. The platform gets a new peered spoke
VNet. Private DNS zones remain centrally managed by the network team — the
platform requests entries but does not own the zone. On-premises connectivity
uses the existing ExpressRoute circuit; no new VPN is required.

**Basis:** Assumes a mid-sized organization already runs a hub-spoke pattern
for other workloads rather than building network topology from zero.

---

### 8. Entra ID groups and ownership
**Category:** OWNERSHIP / GOVERNANCE
**Unblocks:** PLAT-SEC-0001, PLAT-ADR-0003

Existing groups are reused where possible (e.g. `DA-Finance-Readers`,
`DA-Sales-Readers`). New platform-specific groups (`DA-Platform-Admins`,
`DA-Platform-Developers`) are created and owned by the Identity & Access
team. Access-change approvals route through the existing ITSM/ServiceNow
workflow.

**Basis:** Matches the "no second identity system" requirement and a typical
ownership split between the platform team and central IT for group
administration.

---

### 9. Finance stakeholder and cost reporting model
**Category:** BUDGET / COST
**Unblocks:** PLAT-OPS-0001

The Finance Controller (or delegate) is the named stakeholder. Cost
visibility is delivered via a Power BI dashboard fed from Azure Cost
Management, updated daily. Monthly chargeback is allocated by workspace/tag
to business-unit cost centers.

**Basis:** Directly satisfies PARENT-REQ-0005's requirement for
Finance-visible cost tracking from week one of Milestone 1.

---

## Coverage check

All 9 consolidated questions from the source questionnaire are answered
above. No item was left open.

## Next step

Use these figures to unblock the CONDITIONALLY READY / BLOCKED domains from
the build readiness report, or feed them directly into Prompt 00 (Platform
Design Decision) to move Recommendation sections from qualitative to
concrete.
