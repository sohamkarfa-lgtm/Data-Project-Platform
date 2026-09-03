# AGENTS.md

## Repository Purpose

This repository holds the platform-engineering knowledge model, generated platform
specification, and Terraform scaffold for the Data Project Platform. Keep changes
aligned with the intended flow:

1. Validate design intent in `knowledge-model-platform-engineering/`.
2. Generate or refresh the machine-readable contract in `platform-spec/`.
3. Use that contract to update deployable Terraform in `iac/`.

## Instruction File Layout

This repository intentionally uses three `AGENTS.md` files:

- `AGENTS.md` for repository-wide workflow and source-of-truth rules.
- `knowledge-model-platform-engineering/AGENTS.md` for design entity and ADR work.
- `iac/AGENTS.md` for Azure, Microsoft Fabric, and Terraform implementation work.

Do not add more nested agent files unless a subdirectory develops different build,
test, approval, or ownership rules. `platform-spec/` currently uses this root file
because it is generated contract data.

## Source Of Truth

- Treat validated `PLAT-*` entities and approved answer files as the design source
  of truth.
- Treat `platform-spec/` as a generated deployable contract derived from the
  knowledge model.
- Treat `iac/` as implementation of the generated contract.
- Do not invent unresolved client, tenant, subscription, DNS, RBAC, budget, or
  networking values. Preserve or add `[NEEDS HUMAN INPUT: ...]` markers when input
  is missing.
- Keep implementation changes traceable to `PLAT-*`, `PLAT-ADR-*`, or approved
  parent `PARENT-*` references.

## Working Practices

- Read the relevant README before editing a domain: root `README.md`,
  `knowledge-model-platform-engineering/README.md`, or `iac/README.md`.
- Use `rg` or `rg --files` for repository searches.
- Keep changes scoped to the requested workflow stage. Avoid mixing design,
  generated spec, and Terraform changes unless the user asks for the full chain.
- Do not commit secrets, real tenant IDs, subscription IDs, principal IDs, backend
  keys, state files, `.terraform/`, or generated plan files.
- Update `README.md` when changing repository structure, workflow, required checks,
  or agent guidance.

## Verification

- For Markdown and YAML-only changes, inspect formatting and links manually.
- For platform spec changes, compare against the source entities and
  `iac/PLATFORM_SPEC_MAPPING.md`.
- For Terraform changes, follow the nested instructions in `iac/AGENTS.md`.
