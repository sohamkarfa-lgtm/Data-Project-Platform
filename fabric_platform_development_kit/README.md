# Fabric Platform Development Kit

A pluggable, prompt-driven workflow engine for planning and implementing
Microsoft Fabric platform changes — new setups and modifications to the
existing environment alike — through a chained, approval-gated pipeline from
requirement to deployment-ready IaC.

This kit is a **process layer**, not a new source of truth. It reads from,
and ultimately writes into, the existing repository sources of truth:

- `knowledge-model-platform-engineering/` — validated `PLAT-*` design intent
  and `PLAT-ADR-*` decisions
- `platform-spec/` — the generated, environment-scoped deployable contract
- `iac/` — the Terraform implementation

The kit does not replace `prompt-library/` Prompts 00–05. It sits one level
above them: it is the guided front door for a specific requirement or change
request, and its later stages (Solution Design, IaC Development) may invoke
those existing prompts as sub-steps rather than duplicate their logic.

## Why this exists

Ad hoc platform changes bypass the knowledge model's approval discipline and
create drift between `PLAT-*` design intent, `platform-spec/`, and `iac/`.
This kit forces every change — however small it feels at the start — through
the same seven gated stages, so nothing reaches Terraform without a traceable
chain back to a requirement, a design decision, and a validation pass.

## Workflow

```
1. Requirement Analysis        →  runs/<run_id>/01-requirement-analysis.md
2. Current State Assessment    →  runs/<run_id>/02-current-state-assessment.md
3. Gap Analysis                →  runs/<run_id>/03-gap-analysis.md
4. Solution Design & Planning  →  runs/<run_id>/04-solution-design.md
5. IaC Development/Modification→  runs/<run_id>/05-iac-development.md
6. Validation & Testing        →  runs/<run_id>/06-validation-testing.md
7. Deployment Readiness Review →  runs/<run_id>/07-deployment-readiness.md
```

Every stage:
- Consumes only the approved output of the previous stage (plus repo source
  material it's explicitly allowed to read — see each `stage.yaml`).
- Produces one Markdown artifact with YAML frontmatter, written into the
  current run's folder.
- **Stops and asks for explicit human approval before the next stage may
  begin.** No stage may be skipped, reordered, or collapsed.
- Never modifies `/domains`, `/adr`, `platform-spec/`, or `/iac` itself —
  only Stage 5 (IaC Development) writes implementation files, and only after
  Stage 4's design is approved; only Stage 7's sign-off authorizes treating
  Stage 5's output as deployable.

`workflow.yaml` is the machine-readable orchestration definition: stage
order, chaining rules, approval gates, and artifact paths. Each
`stages/<NN-name>/stage.yaml` is that stage's specific contract (inputs,
outputs, allowed read/write scope). Each `stages/<NN-name>/prompt.md` is the
actual prompt to run for that stage.

## Folder structure

```
fabric_platform_development_kit/
├── README.md                      This file
├── AGENTS.md                      Governance rules for agents working in this kit
├── workflow.yaml                  Master orchestration: stage order, chaining, gates
├── config/
│   └── kit-config.yaml            Repo linkage, approval policy, path allow-list
├── stages/
│   ├── 01-requirement-analysis/
│   │   ├── stage.yaml
│   │   └── prompt.md
│   ├── 02-current-state-assessment/
│   │   ├── stage.yaml
│   │   └── prompt.md
│   ├── 03-gap-analysis/
│   │   ├── stage.yaml
│   │   └── prompt.md
│   ├── 04-solution-design/
│   │   ├── stage.yaml
│   │   └── prompt.md
│   ├── 05-iac-development/
│   │   ├── stage.yaml
│   │   └── prompt.md
│   ├── 06-validation-testing/
│   │   ├── stage.yaml
│   │   └── prompt.md
│   └── 07-deployment-readiness/
│       ├── stage.yaml
│       └── prompt.md
├── templates/
│   └── run-manifest.yaml          Blank manifest schema for a new run
└── runs/
    └── _template/                 Copy this folder to start a new run
        ├── manifest.yaml
        ├── 01-requirement-analysis.md
        ├── 02-current-state-assessment.md
        ├── 03-gap-analysis.md
        ├── 04-solution-design.md
        ├── 05-iac-development.md
        ├── 06-validation-testing.md
        └── 07-deployment-readiness.md
```

## Starting a new run

1. Copy `runs/_template/` to `runs/<YYYY-MM-DD>-<change-slug>/`.
2. Fill in `manifest.yaml` with the run id, a one-line title for the change,
   and today's date. Leave every stage's status as `pending`.
3. Open `stages/01-requirement-analysis/prompt.md`, attach the context it
   asks for, and run it. Its output overwrites
   `01-requirement-analysis.md` in your run folder.
4. Review the output. If you approve, set that stage's status to `approved`
   in `manifest.yaml`, record the approver and date, and move to Stage 2.
   If you request edits, the agent revises the same file — the status stays
   `pending` until you explicitly approve.
5. Repeat for each stage in order. Do not open a later stage's prompt until
   the immediately preceding stage shows `approved` in the manifest.

A run is complete when Stage 7's output is approved. At that point the
approved Stage 5 IaC changes and Stage 6 validation report are the basis for
the human's own deployment action (`terraform plan` / `apply`, per
`iac/README.md`) — this kit does not run `terraform apply` itself.

## Relationship to existing prompts

| Existing prompt | Where it fits in this kit |
|---|---|
| `knowledge-model-platform-engineering/prompt-library/platform-design-decision-maker.md` (Prompt 00) | May be invoked inside Stage 4 (Solution Design) when the change requires new or revised `PLAT-*` design entities |
| `.../build-readiness-check.md` (Prompt 02) | May be invoked inside Stage 2 (Current State Assessment) or Stage 6 (Validation) to check design/build readiness |
| `.../platform-questionnaires.md` (Prompt 01) | May be invoked inside Stage 1 (Requirement Analysis) or Stage 3 (Gap Analysis) when open organizational inputs block scoping |
| `.../platform-spec-generator.md` (Prompt 03) | Invoked inside Stage 5 (IaC Development) after a `PLAT-*` design change, before touching `iac/` |
| `.../platform-spec-to-terraform-variables.md` (Prompt 04/05) | Invoked inside Stage 5 (IaC Development) to translate an approved spec into `terraform.tfvars` |

This kit never bypasses those prompts' own approval gates by calling them —
invoking a sub-prompt from within a kit stage still requires that sub-prompt's
own STOP-and-approve step to be honored before the kit stage can be marked
complete.
