# Platform Engineering Knowledge Model

This child knowledge model records the validated platform design decisions for the Data & Analytics modernization engagement.

## Parent model

The parent knowledge model is [Data-Project-Knowledge-Model](https://github.com/sohamkarfa-lgtm/Data-Project-Knowledge-Model). Its validated target-state, ADR, governance, delivery, and requirement entities remain the source constraints for this repository. Cross-repository links use the PARENT-* IDs defined by the parent entities index.

## Domains

- landing-zone — subscriptions, resource groups, environment separation, naming, and tags
- compute — analytics capacity, scaling, and workspace model
- storage — lake zones, lifecycle, retention, and redundancy
- network — private access, segmentation, DNS, and connectivity
- identity-security — Entra ID, RBAC, secrets, and encryption
- operations — cost management, observability, and infrastructure delivery

## Current validated design

The current repo reflects the approved platform posture across all domains:

- Dedicated Data-Analytics management group with separate dev, test, and prod subscriptions
- Fabric as the analytics compute platform with a smaller Milestone 1 capacity baseline and cost guardrails
- ADLS Gen2 bronze/silver/gold structure with retention and lifecycle rules
- Private-by-default network access inside a hub-spoke environment with ExpressRoute coexistence
- Entra ID group-based least-privilege access with Azure Key Vault and managed identity usage
- Finance-visible cost monitoring, operational alerts, and CI/CD governance

## Workflow

1. Read the parent index, schema, and relevant parent entities.
2. Produce or update a design proposal with traceable relates_to links.
3. Obtain explicit human approval.
4. Apply only approved changes and mark the design as validated.
5. Update the registry and validate IDs, paths, frontmatter, and links.

The repository now records the accepted design state rather than unresolved placeholders, and the ADRs and domain entities are kept aligned with the validated decisions.
