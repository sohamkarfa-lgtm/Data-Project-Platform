# Platform Input Questionnaire — 2026-08-31

## Purpose
This questionnaire captures the missing organizational inputs required to finalize the platform design decisions for the current repo. It is intentionally limited to stakeholder questions and does not propose platform choices.

## Quick summary
- Highest-priority decisions: compute sizing, budget, and storage retention
- Cross-domain dependencies: network coexistence and identity governance
- Best audience: Data Platform Owner, Finance, Network, Security, Data Governance, and DevOps

## Priority questions (answer first)

| Priority | Question | Category | Unblocks | Ask |
|---|---|---|---|---|
| 1 | What is the expected Milestone 1 data volume and 12-month growth rate for the analytics platform, in GB or rows, and which source datasets are in scope? | SIZING / VOLUME | PLAT-COMP-0001, PLAT-STOR-0001, PLAT-ADR-0001 | Data Product Owner / Analytics Lead |
| 2 | What is the expected number of concurrent users and peak concurrency expected for key reporting and self-service workloads during business hours? | SIZING / VOLUME | PLAT-COMP-0001, PLAT-ADR-0001 | Business Sponsor / Reporting Lead |
| 3 | What refresh windows, SLA expectations, and concurrency thresholds must the Fabric platform meet for production reporting and downstream consumption? | SIZING / VOLUME | PLAT-COMP-0001, PLAT-ADR-0001 | Data Platform Owner / BI Lead |
| 4 | What is the approved Milestone 1 budget ceiling for Fabric capacity and the related platform services that must stay inside the operating budget? | BUDGET / COST | PLAT-COMP-0001, PLAT-ADR-0001 | Finance Partner / Executive Sponsor |
| 5 | What Azure subscription and management-group boundaries are approved for the platform, and which workloads should sit in which environment boundaries? | OWNERSHIP / GOVERNANCE | PLAT-LZ-0001 | Head of IT Infrastructure / Azure Platform Owner |
| 6 | What retention periods are required for bronze, silver, and gold data, and are there any exception cases for regulatory or operational retention? | COMPLIANCE / REGULATORY | PLAT-STOR-0001 | Data Governance Lead / Compliance Lead |
| 7 | What is the existing Azure hub/VNet topology, private DNS model, and enterprise network standards that the platform must align with? | EXISTING INFRASTRUCTURE / STANDARDS | PLAT-NET-0001, PLAT-ADR-0002 | Head of IT Infrastructure |
| 8 | Which Microsoft Entra ID groups already exist, who owns each group, and which owners are permitted to approve access changes? | OWNERSHIP / GOVERNANCE | PLAT-SEC-0001, PLAT-ADR-0003 | Identity & Access Manager |
| 9 | Who is the Finance stakeholder for the platform, and what reporting access model should be used for cost visibility, budgets, and chargebacks? | BUDGET / COST | PLAT-OPS-0001 | Finance Partner / Platform Sponsor |

## Questions by domain

### Landing Zone
- Q#5 — What Azure subscription and management-group boundaries are approved for the platform, and which workloads should sit in which environment boundaries? (Entities: PLAT-LZ-0001; Category: OWNERSHIP / GOVERNANCE; Ask: Head of IT Infrastructure / Azure Platform Owner)
- Q#6 — What naming convention is approved for Azure, Fabric, environment, workload, and resource names across dev/test/prod? (Entities: PLAT-LZ-0001; Category: EXISTING INFRASTRUCTURE / STANDARDS; Ask: Azure Platform Owner / Enterprise Architecture)
- Q#7 — Which cost-center and data-classification tags are mandatory for Azure and Fabric resources, and who owns the tag policy? (Entities: PLAT-LZ-0001; Category: OWNERSHIP / GOVERNANCE; Ask: Finance / Data Governance Lead)

### Compute
- Q#1 — What is the expected Milestone 1 data volume and 12-month growth rate for the analytics platform, in GB or rows, and which source datasets are in scope? (Entities: PLAT-COMP-0001, PLAT-ADR-0001; Category: SIZING / VOLUME; Ask: Data Product Owner / Analytics Lead)
- Q#2 — What is the expected number of concurrent users and peak concurrency expected for key reporting and self-service workloads during business hours? (Entities: PLAT-COMP-0001, PLAT-ADR-0001; Category: SIZING / VOLUME; Ask: Business Sponsor / Reporting Lead)
- Q#3 — What refresh windows, SLA expectations, and concurrency thresholds must the Fabric platform meet for production reporting and downstream consumption? (Entities: PLAT-COMP-0001, PLAT-ADR-0001; Category: SIZING / VOLUME; Ask: Data Platform Owner / BI Lead)
- Q#4 — What is the approved Milestone 1 budget ceiling for Fabric capacity and the related platform services that must stay inside the operating budget? (Entities: PLAT-COMP-0001, PLAT-ADR-0001; Category: BUDGET / COST; Ask: Finance Partner / Executive Sponsor)

### Storage
- Q#1 — What is the expected Milestone 1 data volume and 12-month growth rate for the analytics platform, in GB or rows, and which source datasets are in scope? (Entities: PLAT-STOR-0001, PLAT-COMP-0001, PLAT-ADR-0001; Category: SIZING / VOLUME; Ask: Data Product Owner / Analytics Lead)
- Q#6 — What retention periods are required for bronze, silver, and gold data, and are there any exception cases for regulatory or operational retention? (Entities: PLAT-STOR-0001; Category: COMPLIANCE / REGULATORY; Ask: Data Governance Lead / Compliance Lead)
- Q#9 — What recovery point objective (RPO) and recovery time objective (RTO) must the storage platform meet for raw ingestion, curated data, and published reporting datasets? (Entities: PLAT-STOR-0001; Category: COMPLIANCE / REGULATORY; Ask: IT Operations Lead / Business Continuity Owner)
- Q#10 — What redundancy and geo-replication requirements apply to ADLS Gen2 for production and non-production workloads? (Entities: PLAT-STOR-0001; Category: COMPLIANCE / REGULATORY; Ask: Infrastructure Architect / Security & Resilience Lead)

### Network
- Q#7 — What is the existing Azure hub/VNet topology, private DNS model, and enterprise network standards that the platform must align with? (Entities: PLAT-NET-0001, PLAT-ADR-0002; Category: EXISTING INFRASTRUCTURE / STANDARDS; Ask: Head of IT Infrastructure)
- Q#8 — What approved on-premises connectivity method and integration pattern should be used for coexistence with the existing mart and source systems? (Entities: PLAT-NET-0001, PLAT-ADR-0002; Category: EXISTING INFRASTRUCTURE / STANDARDS; Ask: Network Architect / Integration Lead)
- Q#9 — What are the approved egress and firewall policies for platform access, including outbound restrictions and segmentation rules? (Entities: PLAT-NET-0001, PLAT-ADR-0002; Category: EXISTING INFRASTRUCTURE / STANDARDS; Ask: Network Security Lead)
- Q#10 — Which public-access exceptions are explicitly permitted, and which services or paths require a documented exception approval? (Entities: PLAT-NET-0001; Category: EXISTING INFRASTRUCTURE / STANDARDS; Ask: Security Lead / Platform Owner)

### Identity & Security
- Q#11 — Which Microsoft Entra ID groups already exist, who owns each group, and which owners are permitted to approve access changes? (Entities: PLAT-SEC-0001, PLAT-ADR-0003; Category: OWNERSHIP / GOVERNANCE; Ask: Identity & Access Manager)
- Q#12 — What is the approved Entra ID group-to-role mapping for platform administrators, developers, operators, and consumers? (Entities: PLAT-SEC-0001, PLAT-ADR-0003; Category: OWNERSHIP / GOVERNANCE; Ask: Identity & Access Manager / Platform Owner)
- Q#13 — What is the required secret rotation policy, including who approves rotation and how often managed identities and platform secrets must rotate? (Entities: PLAT-SEC-0001, PLAT-ADR-0003; Category: COMPLIANCE / REGULATORY; Ask: Security Lead / Platform Ops Lead)
- Q#14 — What compliance requirements apply to identity, data classification, retention, encryption, and recurring access reviews for this platform? (Entities: PLAT-SEC-0001; Category: COMPLIANCE / REGULATORY; Ask: Compliance Lead / Security Lead)

### Operations
- Q#15 — Who is the Finance stakeholder for the platform, and what reporting access model should be used for cost visibility, budgets, and chargebacks? (Entities: PLAT-OPS-0001; Category: BUDGET / COST; Ask: Finance Partner / Platform Sponsor)
- Q#16 — What alert thresholds should trigger notifications for Fabric capacity pressure, pipeline failures, security events, and budget overruns? (Entities: PLAT-OPS-0001; Category: SIZING / VOLUME; Ask: IT Operations Lead / Platform Ops)
- Q#17 — What logging retention periods are required for platform diagnostics, security events, and operational audit trails? (Entities: PLAT-OPS-0001; Category: COMPLIANCE / REGULATORY; Ask: Security Lead / Compliance Lead)
- Q#18 — What CI/CD platform, approval gates, and review workflow must be used for infrastructure and transformation changes in each environment? (Entities: PLAT-OPS-0001; Category: OWNERSHIP / GOVERNANCE; Ask: DevOps Lead / Platform Owner)

## Needs a workshop, not a question
- Network coexistence workshop: Q#7–Q#10 depend on the same enterprise standards and cannot be resolved reliably as isolated written questions.
- Access governance workshop: Q#11–Q#13 require aligned decisions across identity, security, and operations before the access model is stable.

## Coverage check
The current repo snapshot covers the following open items:
- Landing zone: 3
- Compute: 4
- Storage: 4
- Network: 4
- Identity & Security: 4
- Operations: 4
- ADR consequence markers: consolidated into the relevant design questions above

No current `[NEEDS HUMAN INPUT: ...]` marker in this repo is left uncovered.
