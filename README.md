# Data Project Platform

This repository contains the platform engineering design and infrastructure-as-code foundation for the Data and Analytics modernization engagement.

## Repository relationship

The platform model is a child knowledge model of [Data-Project-Accelerator](https://github.com/sohamkarfa-lgtm/Data-Project-Accelerator). The parent repository is the source of enterprise context, requirements, target-state architecture, governance, delivery milestones, and architecture decisions.

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

## Current platform design

The model currently describes a Microsoft Azure and Fabric platform with:

- Separate development, test, and production boundaries
- Microsoft Fabric as the analytics compute layer
- ADLS Gen2 storage using bronze, silver, and gold zones
- Private-by-default connectivity and private endpoints where supported
- Microsoft Entra ID group-based least-privilege access
- Cost visibility, centralized monitoring, and version-controlled delivery

Capacity, retention, recovery, network standards, access mappings, compliance, and other missing sizing inputs remain explicitly recorded as `[NEEDS HUMAN INPUT: ...]` rather than being estimated.

## Change workflow

1. Read the relevant parent entities and schema.
2. Create a traceable platform design proposal.
3. Obtain explicit human approval.
4. Apply only approved changes.
5. Keep new design entities as `draft` until they are separately validated.
6. Update the child registry and validate IDs, paths, frontmatter, and links.

See [Platform Engineering Knowledge Model](knowledge-model-platform-engineering/README.md) for domain conventions and the approval workflow.
