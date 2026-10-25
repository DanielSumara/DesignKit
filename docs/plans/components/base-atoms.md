# Base atoms — implementation plan
Spec: DesignKit/docs/specs/components/base-atoms.md
Repo: DesignKit
Status: Done
Run base: 42052493fd47c83a0d67c57cb9147e3871cac27b

## Slices
### S1 — DesignKit, DesignSystem: Status and component configurations
- ACs: AC-19
- Area: `Sources/DesignKit`, `Sources/DesignSystem/Theme`, `Sources/DesignSystem/Tokens/Primitives`, `Sources/DesignSystem/Inventory`
- Depends on: —
- Skills: design-system
- Review: full
- Builds: `DK.Status` in `Sources/DesignKit/DK+Status.swift` (BR-1, Data); primitives `size48`, `size64` in the `size` scale in order; `DS.Theme.Components` properties `activityIndicator` (`largePlaceholderSize`, `extraLargePlaceholderSize`), `actionButton` (`activityIndicatorDelay` aliasing the `duration` of Motion.quick, BR-4b), `statusIcon` (`color(_:)` per `DK.Status`), defined by `standard`; the two sizes on the scaling list (`DS.Theme.Components+Scaling`); inventory entries for all component tokens with chains
- Done when: a fault-injected theme missing a Data token fails to compile (AC-19), then removed; lint clean; DesignKit and DesignSystem build for iOS and macOS
- Manual ACs: —

### S2 — DesignSystem, DemoApps: Activity Indicator
- ACs: AC-1, AC-2, AC-3
- Area: `Sources/DesignSystem/DS+ActivityIndicator.swift`, `DemoApps/Shared`
- Depends on: S1
- Skills: design-system
- Review: full
- Builds: `DS.ActivityIndicator(label:)` (BR-1, BR-2) with light and dark previews without `.theme(_:)` (BR-13); showcase page file and Catalog entry in sidebar Atoms (Playground, Variants, Configuration)
- Done when: lint clean; package, iOS and the three Showcase builds pass (`scripts/gate.sh`)
- Manual ACs: AC-1, AC-2, AC-3

### S3 — DesignSystem: Action Button
- ACs: —
- Area: `Sources/DesignSystem/DS+ActionButton.swift`, `Sources/DesignSystem/Support`
- Depends on: S2
- Skills: design-system
- Review: full
- Builds: `DS.ActionButton(data:)`, `DS.ActionButton.Style`, `.actionButtonStyle(_:)`, environment value (nil default); look table BR-3, behavior BR-4, BR-4a, keys and roles BR-5; light and dark previews (BR-13)
- Done when: lint clean; package and iOS build with warnings as errors; behavior ACs are verified on the page in S4
- Manual ACs: —

### S4 — DemoApps: Action Button page
- ACs: AC-4, AC-5, AC-6, AC-7, AC-8, AC-9, AC-23, AC-24, AC-26
- Area: `DemoApps/Shared`
- Depends on: S3
- Skills: design-system
- Review: diff-only
- Builds: Action Button showcase page and Catalog entry: Playground (title, role, state, style override, action duration), Variants (role × state, override × role, light and dark), Configuration
- Done when: lint clean; three Showcase builds pass
- Manual ACs: AC-4, AC-5, AC-6, AC-7, AC-8, AC-9, AC-23, AC-24, AC-26

### S5 — DesignSystem, DemoApps: Status Icon
- ACs: AC-10, AC-25
- Area: `Sources/DesignSystem/DS+StatusIcon.swift`, `DemoApps/Shared`
- Depends on: S1
- Skills: design-system
- Review: diff-only
- Builds: `DS.StatusIcon(_:size:label:)` (BR-6) with light and dark previews; showcase page and Catalog entry
- Done when: lint clean; package, iOS and the three Showcase builds pass
- Manual ACs: AC-10, AC-25

### S6 — Docs and canvas: lifecycle
- ACs: AC-17, AC-18, AC-20, AC-34
- Area: Design System canvas, `docs/components.md` (skill `design-system`)
- Depends on: S2, S4, S5
- Skills: design-system
- Review: diff-only
- Builds: three canvas page headers Implemented; `components.md` entries; primitives board lists `size48` and `size64`
- Done when: the three pages checked against AC-17, AC-18, AC-20, AC-34 in the Showcase apps and the canvas
- Manual ACs: AC-17, AC-18, AC-20, AC-34

## AC coverage
| AC | Slice | Verified by |
|---|---|---|
| AC-1 | S2 | manual, Activity Indicator page |
| AC-2 | S2 | manual, Mac and iPhone showcase |
| AC-3 | S2 | manual, VoiceOver |
| AC-4 | S4 | manual, Variants |
| AC-5 | S4 | manual, Playground |
| AC-6 | S4 | manual, Playground |
| AC-7 | S4 | manual, Mac and iPad |
| AC-8 | S4 | manual, Mac |
| AC-9 | S4 | manual, VoiceOver |
| AC-10 | S5 | manual, Status Icon page |
| AC-17 | S6 | manual, three pages |
| AC-18 | S6 | manual, Xcode previews |
| AC-19 | S1 | fault injection, build |
| AC-20 | S6 | manual, Component tokens page |
| AC-23 | S4 | manual, Variants |
| AC-24 | S4 | manual, Variants |
| AC-25 | S5 | manual, Mac |
| AC-26 | S4 | manual, Reduce Motion |
| AC-34 | S6 | manual, canvas |

## Manual verification
- AC-1, AC-2, AC-3 — Activity Indicator page: ShowcaseMac (text size 200 %), ShowcasePhone (largest accessibility size), VoiceOver
- AC-4 to AC-9, AC-23, AC-24, AC-26 — Action Button page: ShowcaseMac and ShowcasePad (keys, inactive window), ShowcasePhone, light and dark, Reduce Motion
- AC-10, AC-25 — Status Icon page: ShowcaseMac, VoiceOver
- AC-17, AC-18, AC-20, AC-34 — all three pages, Xcode previews, Component tokens page, canvas

## Out of scope
- Inline Alert, Edge Case, String Catalog, `DK.AccentTint` mapping (components/base-molecules); `DK.Tone` mapping; platform design-system targets

## Progress
| Slice | Status | Base | Head | Review |
|---|---|---|---|---|
| S1 | Done | bdb328d | 396b7cd | 1 fixed / 0 rejected (iOS Dynamic Type scaling) |
| S2 | Done | 13dbd90 | d94f70d | 0 fixed / 0 rejected |
| S3 | Done | fe6f028 | 22a9bbe | 1 fixed / 0 rejected |
| S4 | Done | 9f4e39c | 3160642 | 2 fixed / 0 rejected |
| S5 | Done | e2db421 | b406b8e | 0 fixed / 0 rejected |
| S6 | Done | 6c21dc5 | 6c21dc5 | no repo code; components.md in HomeBudgetApps, canvas v12 |

## Open questions
- AC-23 (manual): the page has no scene-tint control; the Amendment picker (Sample) changes brand tokens only. Verify whether it suffices when checking AC-23 or add a tint control (spec decision)
- Final review F-1 (rejected, verify on device): on iPhone and iPad a `.bordered` button with `.tint(Color?.none)` may draw the accent color, not a neutral label, and the loading indicator (`.primary`) would then differ from the label (BR-3, BR-4a, AC-23, AC-24). If confirmed, give bordered looks one explicit neutral color used for both label and indicator (a spec decision: native vs token)

## Final review
| Range | Result |
|---|---|
| 42052493..acaa491 | 4 fixed (F-2 to F-5) / 1 rejected (F-1, open question) |
