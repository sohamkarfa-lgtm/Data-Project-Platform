# AGENTS.md

## Required Entry Point For Platform Changes

For requests to provision, create, deploy, resize, or modify Azure/Fabric
platform infrastructure, use `fabric_platform_development_kit/` as the workflow
orchestrator.

Before implementation or cloud actions:

1. Read `fabric_platform_development_kit/AGENTS.md`, its `README.md`,
   `workflow.yaml`, and `config/kit-config.yaml`.
2. Find the relevant existing run and inspect its `manifest.yaml`.
3. Resume the first unapproved stage. Start Stage 1 only if no relevant run exists.
4. Read and follow that stage's `stage.yaml` and `prompt.md`.
5. Report the run ID, active stage, and permitted actions before stage work.

Words such as "provision", "deploy", "go ahead", or "approve Stage N" do not
waive the kit workflow or approve later stages. Record each explicit stage
approval in its artifact and manifest before advancing. Recording an already
reviewed stage's approval is bookkeeping, not execution of another stage.

Use tools only for actions permitted by the active stage. Do not bypass the
workflow through Azure CLI, REST APIs, SDKs, PowerShell, Terraform, portals,
or browser automation. The kit ends with a deployment-readiness handoff; it
does not perform live cloud mutations or real-credential Terraform plans.
Missing tooling is a blocker to record, not permission to switch deployment
methods. Human deployment happens outside the kit after its readiness approval.

Preserve the existing project structure. Prefer existing environment, spec,
and module files. New implementation files or directories require an explicit
need and inclusion in the approved design. The kit's prescribed run artifacts
remain part of its normal workflow.

Explanations, read-only code reviews, and explicitly requested edits to workflow
documentation do not require a new infrastructure run. Such documentation edits
do not approve or advance any pending infrastructure stage.

## Repository Purpose

This repository holds the platform-engineering knowledge model, generated platform
specification, and Terraform scaffold for the Data Project Platform. Keep changes
aligned with the intended flow:

1. Validate design intent in `knowledge-model-platform-engineering/`.
2. Generate or refresh the machine-readable contract in `platform-spec/`.
3. Use that contract to update deployable Terraform in `iac/`.

## Instruction File Layout

This repository intentionally uses four `AGENTS.md` files:

- `AGENTS.md` for repository-wide workflow and source-of-truth rules.
- `knowledge-model-platform-engineering/AGENTS.md` for design entity and ADR work.
- `iac/AGENTS.md` for Azure, Microsoft Fabric, and Terraform implementation work.
- `fabric_platform_development_kit/AGENTS.md` for stage execution and approval rules.

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
