# View state — implementation plan
Spec: DesignKit/docs/specs/components/view-state.md
Repo: DesignKit
Status: In progress
Run base: 22f6c3779c46f07b5fe44c714a35630b0b9a9a51
Depends on: —

## Slices
### S1 — DesignSystem: Component tokens and copy
- ACs: —
- Area: `Sources/DesignSystem/Theme`, `Sources/DesignSystem/Inventory`, `Sources/DesignSystem/Resources`
- Depends on: —
- Skills: design-system
- Review: full
- Builds: `DS.Theme.Components` property `viewState` (`activityIndicatorDelay` as `Components.Delay(\.quick)`, `labelSpacing` Spacing.small) in `DS.Theme.Components+ViewState.swift`, defined by `standard` and every built-in theme, resolved in `DS.Theme.Components+Scaling` like `actionButton.activityIndicatorDelay`, none on the scaling list (BR-11); inventory entries with chains; key `designSystem.viewState.loading` pl and en in `Localizable.xcstrings` (BR-12)
- Done when: lint clean; DesignKit and DesignSystem build for iOS and macOS with warnings as errors
- Manual ACs: —

### S2 — DesignSystem: View State component and previews
- ACs: —
- Area: `Sources/DesignSystem/DS+ViewState.swift`, `Sources/DesignSystem/Support`
- Depends on: S1
- Skills: design-system
- Review: full
- Builds: `DS.ViewState<Content, Loaded: View>(_:loadingLabel:content:)` and content-less `DS.ViewState(_:loadingLabel:)` over `DK.ViewState<Never>` (BR-1, BR-10); one view identity across cases, full-space idle, loading and edge case, ideal size on an unbounded axis (BR-2, BR-9); idle empty and hidden from accessibility (BR-3); delayed indicator without animation, restart rules (BR-4); loading look with `DS.ActivityIndicator` at regular control size, subheadline secondary label, one accessibility element (BR-5, BR-6); `DS.EdgeCaseView` for the edge case (BR-7); loaded content closure (BR-8); light and dark previews of the BR-13 cases
- Done when: lint clean; package and iOS build with warnings as errors; behavior verified on the page in S3
- Manual ACs: —

### S3 — DemoApps: View State page
- ACs: AC-1, AC-2, AC-3, AC-4, AC-5, AC-6, AC-7, AC-8, AC-9, AC-10, AC-11, AC-12, AC-14
- Area: `DemoApps/Shared`, `DemoApps/project.yml`
- Depends on: S2
- Skills: design-system
- Review: diff-only
- Builds: Organisms entry "View State" in the Catalog: Playground (BR-14 controls, replay after 0.1 s or 1 s, `.task` run counter, live `DS.ViewState(…)` snippet), Variants (BR-13 cases light and dark, loading and edge case in a vertical scroll view), Configuration (`viewState` token chains)
- Done when: lint clean; the three Showcase builds pass (`scripts/gate.sh`)
- Manual ACs: AC-1, AC-2, AC-3, AC-4, AC-5, AC-6, AC-7, AC-8, AC-9, AC-10, AC-11, AC-12, AC-14

### S4 — Docs and canvas: lifecycle
- ACs: AC-13
- Area: Design System canvas, `HomeBudgetApps/.claude/skills/design-system/components.md` (skill `design-system`; HomeBudgetApps repo)
- Depends on: S3
- Skills: design-system
- Review: diff-only
- Builds: canvas page "Organism · View State" header Implemented; `components.md` entry
- Done when: the page checked against AC-13 in the Showcase apps and the canvas
- Manual ACs: AC-13

## AC coverage
| AC | Slice | Verified by |
|---|---|---|
| AC-1 | S3 | manual, Playground, counter |
| AC-2 | S3 | manual, Playground |
| AC-3 | S3 | manual, Playground replay |
| AC-4 | S3 | manual, Reduce Motion on, Playground |
| AC-5 | S3 | manual, Polish and English |
| AC-6 | S3 | manual, VoiceOver, Polish and English |
| AC-7 | S3 | manual, ShowcaseMac text size 200 %, ShowcasePhone largest accessibility size |
| AC-8 | S3 | manual, Playground vs Edge Case page, Return on macOS |
| AC-9 | S3 | manual, Playground |
| AC-10 | S3 | manual, Playground with text field content |
| AC-11 | S3 | manual, Variants and Playground |
| AC-12 | S3 | manual, Playground, Variants, Configuration, Component tokens page, Xcode previews |
| AC-13 | S4 | manual, canvas and components.md |
| AC-14 | S3 | manual, Variants in scroll view |

## Manual verification
- AC-1 to AC-12, AC-14 — View State page: ShowcaseMac (text size 200 %, VoiceOver, Return key), ShowcasePhone (largest accessibility text size), Polish and English, light and dark, Reduce Motion, Xcode previews
- AC-13 — canvas page header and `components.md`

## Out of scope
- `DK.ViewState` itself, placeholder or skeleton loading form, determinate progress, refreshing with visible content, pull to refresh, progress inside a button, edge case layout and copy; platform design-system targets

## Progress
| Slice | Status | Base | Head | Review |
|---|---|---|---|---|
| S1 | Done | 22f6c37 | 6d591d3 | 0 fixed / 0 rejected |
| S2 | Done | 152b397 | 5f7d5fb+fix | 2 fixed / 1 rejected |
| S3 | Done | 562aad2 | be91f44+fix | 1 fixed / 0 rejected |
| S4 | Pending | — | — | — |

## Open questions
- Loaded content must be a single root view (S2 review F-1, rejected as unfixable within BR-2; see `docs/pitfalls/view-state.md`): state it in the spec (BR-2 or BR-8) and on the S3 page, or accept multi-root as caller's responsibility
