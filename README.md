# Data Project Platform

This repository contains the platform engineering design and infrastructure-as-code foundation for the Data and Analytics modernization engagement.

## Repository relationship

The platform model is a child knowledge model of [Data-Project-Knowledge-Model](https://github.com/sohamkarfa-lgtm/Data-Project-Knowledge-Model). The parent repository is the source of enterprise context, requirements, target-state architecture, governance, delivery milestones, and architecture decisions.

The child model links back to parent entities with `PARENT-*` IDs and keeps its own `PLAT-*` entity registry. The parent relationship is declared in [knowledge-model-platform-engineering/entities.index.yaml](knowledge-model-platform-engineering/entities.index.yaml).

## Repository structure

```text
/iac/
	Infrastructure-as-code implementation area
/knowledge-model-platform-engineering/
	Platform design knowledge model
	/domains/
		landing-zone/       Environment and Azure/Fabric landing-zone design
		compute/             Fabric capacity, scaling, and workspace design
		storage/             ADLS Gen2 zones, lifecycle, retention, and redundancy
		network/             Private access, segmentation, DNS, and connectivity
		identity-security/   Entra ID, RBAC, secrets, and encryption
		operations/          Cost management, observability, and CI/CD
	/adr/                  Platform architecture decision records
	/prompt-library/       Approval-gated platform design prompts
	entities.index.yaml    Registry of platform entities
```

## Current validated platform design

The model describes a Microsoft Azure and Fabric platform with:

- Separate development, test, and production subscriptions and workspaces
- Microsoft Fabric as the analytics compute layer, sized to a Milestone 1 workload profile
- ADLS Gen2 storage with bronze, silver, and gold zones and retention-based lifecycle policies
- Private-by-default connectivity inside a hub-spoke network model with ExpressRoute coexistence
- Microsoft Entra ID group-based least-privilege access and Azure Key Vault for secrets
- Cost visibility, budget alerts, centralized monitoring, and version-controlled delivery

Validated assumptions include:

- ~800 GB initial load across the Milestone 1 scope
- ~150 peak concurrent sessions during reporting periods
- $10,000-$14,000 per month for Fabric and adjacent services
- Dev/test capped at $2,000 per month
- One regulated Finance domain with a 7-year gold retention baseline

## Change workflow

1. Read the relevant parent entities and schema.
2. Produce or update a traceable platform design proposal.
3. Obtain explicit human approval.
4. Apply only approved changes and mark them as validated.
5. Keep the design record consistent across domain entities, ADRs, and the registry.
6. Validate IDs, paths, frontmatter, and links before delivery.

See [Platform Engineering Knowledge Model](knowledge-model-platform-engineering/README.md) for the domain conventions and decision model.
