# Modal sheet — implementation plan
Spec: DesignKit/docs/specs/components/modal-sheet.md
Repo: DesignKit
Status: Done
Run base: fefb8656820e81d1502639525b4d8e9d23a4ad20
Depends on: —

## Slices
### S1 — DesignKit, DesignSystem: Data, tokens and copy
- ACs: —
- Area: `Sources/DesignKit`, `Sources/DesignSystem/Theme`, `Sources/DesignSystem/Tokens/Primitives`, `Sources/DesignSystem/Inventory`, `Sources/DesignSystem/Resources`
- Depends on: —
- Skills: design-system
- Review: full
- Builds: `DK.ModalSheet` in `Sources/DesignKit/DK+ModalSheet.swift` (Data); primitives `size480`, `size560`, `size640` in the `size` scale in order; `DS.Theme.Components` property `modalSheet` (`standardWidth`, `wideWidth`, `maxHeight`, `headerSpacing`, `contentSpacing`, `padding`), defined by `standard`, the three sizes on the scaling list (`DS.Theme.Components+Scaling`) (BR-9); inventory entries with chains; the four `designSystem.modalSheet.*` keys pl and en in `Localizable.xcstrings` (BR-10)
- Done when: lint clean; DesignKit and DesignSystem build for iOS and macOS with warnings as errors
- Manual ACs: —

### S2 — DesignSystem: Modal Sheet structure, actions, discard, busy
- ACs: —
- Area: `Sources/DesignSystem/DS+ModalSheet.swift`, `Sources/DesignSystem/Support`
- Depends on: S1
- Skills: design-system
- Review: full
- Builds: `DS.ModalSheet<Content>(_:width:content:)` and `DS.ModalSheet.Width` (BR-1 port of FinanceTracker `DS.FormSheet`); iOS/iPadOS `NavigationStack` header and bar actions, macOS header and button row (BR-2, BR-3); forced roles and keys; cancel path, discard confirmation per platform, swipe-down handling (BR-4, BR-5); busy tracking by wrapping the confirm action, disabled Cancel and content (BR-6); content slot (BR-8); support types in `Support`
- Done when: lint clean; package and iOS build with warnings as errors; behavior is verified on the page in S4
- Manual ACs: —

### S3 — DesignSystem: Sizing and previews
- ACs: —
- Area: `Sources/DesignSystem/DS+ModalSheet.swift`, `Sources/DesignSystem/Support`, `docs/pitfalls`
- Depends on: S2
- Skills: design-system
- Review: full
- Builds: macOS sizing from `standardWidth`, `wideWidth`, `maxHeight` and the content's height (BR-7): `presentationSizing(.fitted)` tried first, FinanceTracker measurement approach as fallback (Q-3); iPad system form and page sizing, iPhone full height; outcome recorded in `docs/pitfalls/modal-sheet.md`; light and dark previews of all BR-11 cases
- Done when: lint clean; package and iOS build with warnings as errors; macOS sizing outcome recorded in the pitfalls file
- Manual ACs: —

### S4 — DemoApps: Modal Sheet page
- ACs: AC-1, AC-2, AC-3, AC-4, AC-5, AC-6, AC-7, AC-8, AC-9, AC-10, AC-11, AC-12, AC-13, AC-14
- Area: `DemoApps/Shared`, `DemoApps/project.yml`
- Depends on: S3
- Skills: design-system
- Review: diff-only
- Builds: Templates sidebar section, Modal Sheet page and Catalog entry: Playground (BR-13 controls, 2 s confirm action, sample content few rows or long list, live `DK.ModalSheet(…)` snippet), Variants (BR-11 cases, light and dark), Configuration (`modalSheet` token chains)
- Done when: lint clean; the three Showcase builds pass (`scripts/gate.sh`)
- Manual ACs: AC-1, AC-2, AC-3, AC-4, AC-5, AC-6, AC-7, AC-8, AC-9, AC-10, AC-11, AC-12, AC-13, AC-14

### S5 — Docs and canvas: lifecycle
- ACs: AC-15
- Area: Design System canvas, `docs/components.md` (skill `design-system`)
- Depends on: S4
- Skills: design-system
- Review: diff-only
- Builds: canvas page "Template · Modal Sheet" header Implemented; `components.md` entry; primitives board lists `size480`, `size560`, `size640`
- Done when: the page checked against AC-15 in the Showcase apps and the canvas
- Manual ACs: AC-15

## AC coverage
| AC | Slice | Verified by |
|---|---|---|
| AC-1 | S4 | manual, ShowcasePhone and ShowcasePad (hardware keyboard) |
| AC-2 | S4 | manual, ShowcaseMac |
| AC-3 | S4 | manual, ShowcaseMac and ShowcasePhone, Playground |
| AC-4 | S4 | manual, Mac and iPhone/iPad swipe |
| AC-5 | S4 | manual, Playground |
| AC-6 | S4 | manual, ShowcasePhone and ShowcasePad |
| AC-7 | S4 | manual, Mac and iPad |
| AC-8 | S4 | manual, Playground with 2 s action |
| AC-9 | S4 | manual, Playground |
| AC-10 | S4 | manual, ShowcaseMac and ShowcasePad |
| AC-11 | S4 | manual, ShowcaseMac text size 200 % |
| AC-12 | S4 | manual, Polish and English |
| AC-13 | S4 | manual, VoiceOver on ShowcaseMac |
| AC-14 | S4 | manual, Playground, Variants, Xcode previews |
| AC-15 | S5 | manual, canvas and components.md |

## Manual verification
- AC-1 to AC-14 — Modal Sheet page: ShowcaseMac (text size 200 %, VoiceOver, keys), ShowcasePad (hardware keyboard), ShowcasePhone, Polish and English, light and dark, Xcode previews
- AC-15 — canvas page header and `components.md`

## Out of scope
- Presenting and dismissing the sheet, form layout (components/form-fields), destructive and role-less actions, detents, nested sheets, navigation pushes, inspector and popover presentations, discard confirmation after a swipe down; platform design-system targets

## Progress
| Slice | Status | Base | Head | Review |
|---|---|---|---|---|
| S1 | Done | fefb865 | 05e0128 | 0 fixed / 0 rejected |
| S2 | Done | 05e0128 | 190a035 | 1 fixed / 1 rejected |
| S3 | Done | 190a035 | 31bd079 | 0 fixed / 0 rejected |
| S4 | Done | 31bd079 | 8f051c1 | 0 fixed / 1 rejected |
| S5 | Done | 769e066 | — | docs and canvas, no commit in DesignKit |
| Final | Done | fefb865 | 769e066 | 3 fixed / 0 rejected |

## Open questions
- Spec and plan name `DS.ModalSheet.Width`; code has top-level `DS.ModalSheetWidth` with `typealias Width` inside `DS.ModalSheet<Content>` (Swift cannot reference a nested type of a generic without arguments). Spec wording needs the user's decision (S2 review R-2, rejected)
