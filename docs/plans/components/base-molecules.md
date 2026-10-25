# Base molecules — implementation plan
Spec: DesignKit/docs/specs/components/base-molecules.md
Repo: DesignKit
Status: In progress
Run base: fd11cfb92f33d19673ae03094eda7476358fd933

## Slices
Requires the base-atoms plan `Done` (Status Icon, Action Button, `DK.Status`).

### S1 — DesignKit, DesignSystem: Inline Alert data, tokens, String Catalog
- ACs: AC-19
- Area: `Sources/DesignKit`, `Sources/DesignSystem/Theme`, `Sources/DesignSystem/Inventory`, `Sources/DesignSystem/Resources`, `Package.swift`, `docs/specs/foundations/package-and-showcase.md`
- Depends on: —
- Skills: design-system
- Review: full
- Builds: `DK.InlineAlert` and `DK.InlineAlert.Notice` in `Sources/DesignKit/DK+InlineAlert.swift` (BR-1, Data); `DS.Theme.Components` properties `inlineAlert` and `edgeCase` with all Data tokens, `standard` values, scaling list entries (`inlineAlert.iconSize`, `edgeCase.iconSize`), inventory entries; sample amendment override `inlineAlert.radius` = Radius.large (BR-11); `Sources/DesignSystem/Resources/Localizable.xcstrings` with the four `designSystem.statusIcon.*` keys pl and en, resources declared in `Package.swift`; package-and-showcase BR-1 marked superseded by BR-12
- Done when: a fault-injected theme missing a Data token fails to compile, then removed; every Copy key has pl and en; BR-1 marked superseded; lint clean; DesignKit and DesignSystem build for iOS and macOS
- Manual ACs: —

### S2 — DesignSystem, DemoApps: Inline Alert
- ACs: AC-11, AC-12, AC-13, AC-21, AC-29, AC-35
- Area: `Sources/DesignSystem/DS+InlineAlert.swift`, `DemoApps/Shared`
- Depends on: S1
- Skills: design-system
- Review: full
- Builds: `DS.InlineAlert(_:)` (BR-7, BR-8) using `DS.StatusIcon` and the catalog status words, light and dark previews; showcase page and Catalog entry in sidebar Molecules (Playground with one to three notices, Variants, Configuration)
- Done when: lint clean; package, iOS and the three Showcase builds pass
- Manual ACs: AC-11, AC-12, AC-13, AC-21, AC-29, AC-35

### S3 — DesignKit, DesignSystem: Edge Case view, AccentTint, ImageIO
- ACs: AC-32
- Area: `Sources/DesignSystem/DS+EdgeCaseView.swift`, `Sources/DesignSystem/Support`, `CLAUDE.md` (workspace), `docs/architecture.md` §3
- Depends on: S1
- Skills: design-system
- Review: full
- Builds: `DS.EdgeCaseView(_:)` (BR-9) with system unavailable-content view, ImageIO decoding and `photo` fallback, monogram; `internal` `DK.AccentTint` background and foreground mapping (Data, Q-9); light and dark previews; Allowed imports line "DesignSystem: DesignKit, SwiftUI, ImageIO" in workspace `CLAUDE.md` and architecture §3, same commit
- Done when: lint clean; package and iOS build with warnings as errors; both docs list ImageIO (AC-32)
- Manual ACs: —

### S4 — DemoApps: Edge Case page
- ACs: AC-14, AC-15, AC-22, AC-27
- Area: `DemoApps/Shared`, `DemoApps` assets
- Depends on: S3
- Skills: design-system
- Review: diff-only
- Builds: Edge Case page and Catalog entry: Playground (icon kind incl. undecodable bytes, symbol, initials, tint, title, message, zero to three actions), Variants, Configuration; a DemoApps image asset read as `Data`
- Done when: lint clean; three Showcase builds pass
- Manual ACs: AC-14, AC-15, AC-22, AC-27

### S5 — Docs and canvas: lifecycle and cross-checks
- ACs: AC-16, AC-17, AC-18, AC-28, AC-30, AC-31, AC-33
- Area: Design System canvas, `docs/components.md` (skill `design-system`)
- Depends on: S2, S4
- Skills: design-system
- Review: diff-only
- Builds: canvas headers Implemented, `components.md` entries, Inline Alert canvas snippet and Configuration with `Notice.status: DK.Status`, Edge Case Configuration with `iconSize`, `imageRadius` and changelog entry
- Done when: both pages checked against the listed ACs on Mac, iPad and iPhone and in the canvas
- Manual ACs: AC-16, AC-17, AC-18, AC-28, AC-30, AC-31, AC-33

## AC coverage
| AC | Slice | Verified by |
|---|---|---|
| AC-11 | S2 | manual, Variants |
| AC-12 | S2 | manual, Mac text sizes |
| AC-13 | S2 | manual, VoiceOver pl and en |
| AC-14 | S4 | manual, Edge Case page |
| AC-15 | S4 | manual, Playground |
| AC-16 | S5 | manual, Component tokens page, sample amendment |
| AC-17 | S5 | manual, two pages |
| AC-18 | S5 | manual, Xcode previews |
| AC-19 | S1 | fault injection, catalog check |
| AC-21 | S2 | manual, Playground |
| AC-22 | S4 | manual, Mac 200 % |
| AC-27 | S4 | manual, VoiceOver |
| AC-28 | S5 | manual, iPhone largest size |
| AC-29 | S2 | manual, Variants |
| AC-30 | S5 | manual, three platforms |
| AC-31 | S5 | manual, canvas |
| AC-32 | S3 | docs diff |
| AC-33 | S5 | manual, canvas |
| AC-35 | S2 | manual, Playground |

## Manual verification
- AC-11, AC-12, AC-13, AC-21, AC-29, AC-35 — Inline Alert page: ShowcaseMac, light and dark, VoiceOver pl and en
- AC-14, AC-15, AC-22, AC-27 — Edge Case page: ShowcaseMac (Return key, 200 %), VoiceOver
- AC-16, AC-17, AC-18, AC-28, AC-30, AC-31, AC-33 — both pages on all three showcase apps, Component tokens page, canvas

## Out of scope
- Activity Indicator, Action Button, Status Icon (components/base-atoms); `DK.Tone`; platform design-system targets

## Progress
| Slice | Status | Base | Head | Review |
|---|---|---|---|---|
| S1 | Done | 6bf539f | fb1bfc2 | 1 fixed / 0 rejected |
| S2 | Done | 2088584 | f4cec1c | 1 fixed / 0 rejected |
| S3 | Done | 130a62d | 3c0cf79 | 2 fixed / 0 rejected |
| S4 | Pending | — | — | — |
| S5 | Pending | — | — | — |

## Open questions
- None
