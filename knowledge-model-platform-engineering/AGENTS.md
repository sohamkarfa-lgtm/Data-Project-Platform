# AGENTS.md

## Scope

These instructions apply to the platform-engineering knowledge model. This area is
the validated design source for the generated `platform-spec/` contract and the
Terraform implementation under `iac/`.

## Entity Rules

- Use the frontmatter convention documented in
  `knowledge-model-platform-engineering/schemas/entity-schema.yaml`.
- Keep entity IDs stable. New platform entities must use the `PLAT-<DOMAIN>-0000`
  pattern and be added to `entities.index.yaml`.
- Preserve `PARENT-*` references when they link back to the parent knowledge model.
- Use the relevant `_template.md` file when adding domain entities or ADRs.
- Keep `relates_to` links meaningful and update both the entity and registry when
  adding or moving records.

## Approval Workflow

- Do not mark an entity `validated` unless the change is based on explicit human
  approval or already-approved source material.
- Use `draft` or `proposed` for work that still needs approval.
- Keep source notes specific enough to trace where the decision came from.
- Do not silently overwrite accepted design decisions; create a new ADR or update
  the existing ADR with clear context when a decision changes.

## Domain Guidance

- Domain records live under `domains/<domain>/`.
- ADRs live under `adr/`.
- Prompt assets live under `prompt-library/` and should remain approval-gated.
- Keep current platform assumptions aligned across landing zone, compute, storage,
  network, identity-security, operations, and ADR files.

## Verification

- After entity changes, check `entities.index.yaml` for every added, renamed, or
  removed entity.
- Inspect frontmatter keys against the schema convention.
- Search for stale links or IDs with `rg "PLAT-|PARENT-" knowledge-model-platform-engineering`.
- If changes should affect deployment, update or regenerate `platform-spec/` and
  then follow the root and `iac/` instructions.
