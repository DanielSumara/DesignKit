# Package and showcase — implementation plan
Spec: DesignKit/docs/specs/foundations/package-and-showcase.md
Repo: DesignKit
Status: In progress
Baseline: empty
Run base: 8c1facc7ada531d80912b2b144f82760092c84f6

## Slices
### S1 — Package: skeleton, DK/DS port, build commands
- ACs: AC-1, AC-2, AC-5, AC-17
- Area: `Package.swift`, `Sources/DesignKit`, `Sources/DesignSystem`, `CLAUDE.md` › Commands
- Depends on: —
- Skills: design-system
- Review: full
- Builds: products and targets `DesignKit` and `DesignSystem`; `DK` (`DK.swift`, `DK+{ViewState,EdgeCase,ActionButton,Alert,Tone,Option,Icon,AccentTint,TextSize}.swift`); `DS` (`DS.swift`); the Commands build lines with warning flags (forms of BR-11 steps 2, 3, 5)
- Done when: AC-1 command and AC-2 command pass; AC-5 file list and AC-17 diff checked once; lint clean; DesignKit builds for macOS and iOS
- Manual ACs: —

### S2 — Showcase: DemoApps project, three apps, sidebar and empty detail, lint widened
- ACs: AC-3, AC-4, AC-9, AC-10, AC-11
- Area: `DemoApps/project.yml`, `DemoApps/Shared/`, `DemoApps/Phone/`, `DemoApps/Pad/`, `DemoApps/Mac/`, `.swiftlint.yml`, `.gitignore`
- Depends on: S1
- Skills: design-system
- Review: diff-only
- Builds: `DemoApps/Shared/Section.swift` (five sections with titles), `Page.swift` (`id`, `title`, `section`, single-view body), `Catalog.swift` (shared pages plus the app's platform pages; no entries yet), `ShowcaseRoot.swift` (`NavigationSplitView`: sidebar with "No pages yet" rows, "Select a page" empty detail); app entries `Phone/ShowcasePhoneApp.swift`, `Pad/ShowcasePadApp.swift`, `Mac/ShowcaseMacApp.swift` (single `Window`, no New Window); schemes ShowcasePhone, ShowcasePad, ShowcaseMac; `no_literal_styling` including `DemoApps/`; `Showcase.xcodeproj` untracked
- Done when: `xcodegen generate` succeeds and the three builds of BR-11 step 5 pass with warnings as errors; AC-3 fault injection (a `.padding(8)` in a `DemoApps/` file is reported, then removed) and lint clean; `git status` shows no tracked project
- Manual ACs: AC-9, AC-10, AC-11 (checked with the Page anatomy page, after S4)

### S3 — Showcase: component page model, Appearance
- ACs: AC-12, AC-14
- Area: `DemoApps/Shared/`
- Depends on: S2
- Skills: design-system
- Review: full
- Builds: `Page` body extended with the component case (`ComponentPage` content: Playground preview, controls and snippet; Variants `[name, view]`; Configuration properties and tokens); `ComponentPageView.swift` (toolbar segmented picker, Playground / Variants / Configuration, Playground default, "None" for empty sections); `PlaygroundEnvironment.swift` (`appearance`: system, light, dark; shared for the app session, outside page state); `AppearancePicker`; Variants light/dark renderings on their own appearance backgrounds
- Done when: lint clean; the three showcase apps build with warnings as errors; a `#Preview` of a component page with sample content renders
- Manual ACs: AC-12, AC-14 (checked on Page anatomy, after S4)

### S4 — Showcase: Page anatomy
- ACs: AC-13, AC-15, AC-16, AC-18
- Area: `DemoApps/Shared/`
- Depends on: S3
- Skills: design-system
- Review: diff-only
- Builds: `PageAnatomyPage.swift` (type `PageAnatomyPage`; Copy keys `showcase.anatomy.*`; sample text control, snippet with `\` and `"` escaping, Short and Long variants, `sampleText` property, tokens "None", per-tab one-line intros); one entry in `Catalog.swift` (Foundations)
- Done when: lint clean; the three showcase apps build with warnings as errors; AC-18 search: `PageAnatomyPage` matches exactly `PageAnatomyPage.swift` and `Catalog.swift` in `DemoApps/`
- Manual ACs: AC-13, AC-15, AC-16 (and S2, S3 manual ACs, now that the page exists)

### S5 — Gate: scripts/gate.sh
- ACs: AC-6, AC-7, AC-8
- Area: `scripts/gate.sh`, `CLAUDE.md` › Commands
- Depends on: S4
- Skills: design-system
- Review: diff-only
- Builds: `scripts/gate.sh` (step 0 tool check, steps 1–5 of BR-11, log file in `$TMPDIR` or argument 1, one line per step, at most 20 `error:` lines on failure); CLAUDE.md Commands gate line
- Done when: AC-6 run exits 0 with every step pass; AC-7 and AC-8 fault injection done and reverted; lint clean
- Manual ACs: —

## AC coverage
| AC | Slice | Verified by |
|---|---|---|
| AC-1 | S1 | command `xcrun swift build --build-system swiftbuild -Xswiftc -warnings-as-errors`; `swift package dump-package` lists products DesignKit and DesignSystem |
| AC-2 | S1 | command `xcodebuild -scheme DesignSystem -destination 'generic/platform=iOS' build SWIFT_TREAT_WARNINGS_AS_ERRORS=YES` |
| AC-3 | S2 | gate step 1 (`swiftlint lint --strict --quiet`); fault injection: `.padding(8)` in a `DemoApps/` file reported by `no_literal_styling` |
| AC-4 | S2 | `xcodegen generate`, then the three builds of gate step 5; `git status` / `git ls-files` shows `Showcase.xcodeproj` untracked |
| AC-5 | S1 | file list: `ls Sources/DesignKit Sources/DesignSystem` equals the listed files, no subfolders or resources |
| AC-6 | S5 | `scripts/gate.sh` on a clean repo: every step pass, exit 0 |
| AC-7 | S5 | fault injection per kind (lint violation, compile error, Swift warning): stops at that step, ≤ 20 `error:` lines, log path, non-zero exit, no later step |
| AC-8 | S5 | fault injection: `xcodegen` removed from `PATH`; fails before step 1 naming it |
| AC-9 | S2 | manual: ShowcasePhone, iPhone simulator |
| AC-10 | S2 | manual: ShowcasePad, iPad simulator, landscape and portrait |
| AC-11 | S2 | manual: ShowcaseMac, macOS |
| AC-12 | S3 | manual: Page anatomy in ShowcasePhone, ShowcasePad, ShowcaseMac |
| AC-13 | S4 | manual: Page anatomy Playground in ShowcaseMac (text editing; `"` and `\` escaping; cleared text) |
| AC-14 | S3 | manual: Page anatomy Playground in ShowcaseMac with the system in dark mode; reopen within the session |
| AC-15 | S4 | manual: Page anatomy Variants in ShowcasePhone and ShowcaseMac (Long wraps ≥ 3 lines) |
| AC-16 | S4 | manual: Page anatomy Configuration in ShowcaseMac |
| AC-17 | S1 | `git diff --no-index -w` of each ported file against its FinanceTracker `Kits/DesignKit` source; only Q-4 and SwiftLint formatting differ |
| AC-18 | S4 | search of `DemoApps/` for `PageAnatomyPage`: exactly two files |

## Manual verification
- AC-9 — ShowcasePhone, iPhone simulator: sections in order, Foundations lists Page anatomy, others "No pages yet", tap pushes, Back returns
- AC-10 — ShowcasePad, iPad simulator: landscape shows sidebar and "Select a page"; selecting Page anatomy shows it; portrait sidebar button toggles
- AC-11 — ShowcaseMac: one window, "Select a page", Page anatomy selectable, toolbar toggle works, File menu has no New Window
- AC-12 — any app: picker with the three tabs, Playground selected, each tab per spec
- AC-13 — ShowcaseMac: edit sample text, preview and snippet update per keystroke, escaping, empty text
- AC-14 — ShowcaseMac, system dark: Appearance Light/Dark/System on the preview only, chrome stays dark; leave and reopen the page
- AC-15 — ShowcasePhone and ShowcaseMac: Short and Long, light and dark columns, Long wraps onto ≥ 3 lines
- AC-16 — ShowcaseMac: Properties `sampleText` / `String` / default, Component tokens "None"
- S3 and S4 are checked together once S4 lands: S3 has no page to show until Page anatomy exists (its check is the `#Preview`).

## Out of scope
- Theme, tokens, `mds`, `@MDS`, text size; Theme, Amendment and Text size controls
- Components; `Locale+Localized`, `WrappingLayout`, DesignSystem String Catalog
- MacDesignSystem, PadDesignSystem, PhoneDesignSystem
- Release tag, `CHANGELOG.md`; restoring the selected page or tab across launches

## Progress
| Slice | Status | Base | Head | Review |
|---|---|---|---|---|
| S1 | Done | 8c1facc | 76e417d | 0 fixed / 0 rejected |
| S2 | Done | 07f5606 | 21c9d80 | 0 fixed / 0 rejected |
| S3 | Done | 2140771 | 31c928a | 1 fixed / 0 rejected |
| S4 | Pending | — | — | — |
| S5 | Pending | — | — | — |

## Open questions
- None
