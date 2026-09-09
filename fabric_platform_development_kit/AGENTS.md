# AGENTS.md

## Scope

These instructions apply to `fabric_platform_development_kit/`. This kit is a
process/orchestration layer above the existing sources of truth
(`knowledge-model-platform-engineering/`, `platform-spec/`, `iac/`). It does
not own design intent, the generated contract, or the Terraform
implementation — it owns the traceable path a change takes through them.

## Read First

Before running any stage, read:

- `README.md` (this kit's own)
- `workflow.yaml`
- `config/kit-config.yaml`
- The specific stage's `stage.yaml` and `prompt.md`
- The current run's `manifest.yaml`, to confirm the preceding stage is
  `approved` before starting

## Hard Rules

- **Sequential only.** Never run a stage whose predecessor is not `approved`
  in the run's `manifest.yaml`. Never run two stages in the same turn.
- **Chained inputs only.** Each stage's primary input is the approved output
  file of the previous stage. Do not re-derive scope from the original
  request once Stage 1 is approved — the requirement specification is now
  the requirement, and later stages that disagree with it raise a
  `[CONFLICT NEEDS HUMAN RESOLUTION]` rather than silently reinterpreting it.
- **No IaC before design approval.** Stage 5 may not create or edit any file
  under `iac/` or `platform-spec/` until Stage 4's design proposal has
  `status: approved` in the manifest.
- **No deployment action before validation approval.** This kit never runs
  `terraform apply` (and does not run `terraform plan` against real
  credentials) at any stage. Stage 7's output is a readiness package for the
  human to act on outside this kit.
- **One artifact per stage.** Each stage writes exactly one Markdown file
  into the run folder, named per `workflow.yaml`. Do not create additional
  files outside the run folder unless the stage's own `stage.yaml` explicitly
  allows it (Stage 5 is the only stage with permission to write outside its
  run folder, and only into `iac/` / `platform-spec/`, and only after
  approval).
- **Preserve `[NEEDS HUMAN INPUT: ...]` and `[CONFLICT NEEDS HUMAN
  RESOLUTION]` markers** exactly as the upstream knowledge-model conventions
  require (see root `AGENTS.md` and
  `knowledge-model-platform-engineering/AGENTS.md`). Do not resolve a marker
  by inference at a later stage just because it would be convenient.
- **Minimize blast radius.** Prefer the smallest change that satisfies the
  approved design. Reuse existing `iac/modules/*` and `PLAT-*` entities
  before proposing new ones.
- **Traceability.** Every stage output must cite the specific IDs
  (`PLAT-*`, `PLAT-ADR-*`, `PARENT-*`, spec fields, `.tf` paths) it is based
  on or changes. An unsourced claim in a later stage is a defect in that
  stage's output, not an acceptable shortcut.

## Approval Workflow

Each stage's `prompt.md` ends with a STOP instruction and an explicit
approval question, matching the pattern already used throughout
`prompt-library/`. On approval:

1. Update the run's `manifest.yaml`: set that stage's `status: approved`,
   `approved_by`, and `approved_at`.
2. Only then may the next stage's `prompt.md` be run.

On rejection or requested edits, the agent revises the same stage's output
file in place; `status` stays `pending` (or moves to `changes_requested`)
until the human approves the revised version.

## Verification

Before considering a run's Stage 5 output complete, confirm:

- Every file it touches under `iac/` or `platform-spec/` was named in Stage
  4's approved design proposal.
- No file outside the approved scope was modified.
- Every `PLAT-*` / `PLAT-ADR-*` reference used still resolves in
  `knowledge-model-platform-engineering/entities.index.yaml`.

Before considering a run complete (Stage 7 approved), confirm:

- All seven stage files exist in the run folder and are each `approved` in
  `manifest.yaml`.
- The Stage 6 validation report has no unresolved blocking findings, or each
  is explicitly accepted as a known risk by the human approver in Stage 7.
