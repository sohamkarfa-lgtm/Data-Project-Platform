# Platform Engineering Knowledge Model

This child knowledge model records platform design decisions for the Data & Analytics modernization engagement.

## Parent model

The parent knowledge model is [Data-Project-Accelerator](https://github.com/sohamkarfa-lgtm/Data-Project-Accelerator). Its validated target-state, ADR, governance, delivery, and requirement entities are the source constraints for this repository. Cross-repository links use the `PARENT-*` IDs defined by the parent `entities.index.yaml`.

## Domains

- `landing-zone` — subscriptions, resource groups, environments, naming, and tags
- `compute` — analytics capacity, scaling, and workspaces
- `storage` — lake zones, lifecycle, retention, and redundancy
- `network` — private access, segmentation, DNS, and connectivity
- `identity-security` — Entra ID, RBAC, secrets, and encryption
- `operations` — cost management, observability, and infrastructure delivery

## Workflow

1. Read the parent index, schema, and relevant parent entities.
2. Produce a design proposal with traceable `relates_to` links.
3. Obtain explicit human approval.
4. Apply only approved changes with `status: draft` until separately validated.
5. Update `entities.index.yaml` and validate IDs, paths, frontmatter, and links.

Do not invent missing sizing, budget, compliance, ownership, or recovery inputs. Record them as `[NEEDS HUMAN INPUT: ...]`.
