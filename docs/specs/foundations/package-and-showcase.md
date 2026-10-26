# Package and showcase
Status: Implemented · Repo: DesignKit · Feature: foundations · Module or target: `Package.swift`, DesignKit, DesignSystem, `DemoApps/`, `scripts/gate.sh`, `.swiftlint.yml` · Depends on: —

## Goal
A buildable package skeleton with the fundamentals every later spec builds on, the three showcase apps to verify it in, and a single command (the gate) that checks the repo. After this spec, a token, theme or component spec adds only its own code and its showcase page.

## Scope
- In:
  - `Package.swift` with the targets DesignKit and DesignSystem
  - fundamentals ported from FinanceTracker `Kits/DesignKit`: `DK` namespace, `DK.ViewState`, `DK.EdgeCase`, `DK.ActionButton`, `DK.Alert`, `DK.Tone`, `DK.Option`, `DK.Icon`, `DK.AccentTint`, `DK.TextSize`; `DS` namespace
  - `DemoApps/project.yml` generating ShowcasePhone, ShowcasePad and ShowcaseMac over `DemoApps/Shared/`
  - the showcase shell: sidebar, empty-state detail, page model, Appearance control, the Page anatomy page
  - `scripts/gate.sh`
  - `no_literal_styling` covering `DemoApps/` (Q-6)
- Out:
  - Theme, tokens, `mds`, `@MDS`, text size scaling (specs `foundations/tokens`, `foundations/theme-and-mds`)
  - Theme, Amendment and Text size playground controls (added by `foundations/theme-and-mds`, Q-2)
  - Every component, including the FinanceTracker ones (`components/…` specs)
  - `Locale+Localized`, `WrappingLayout` and DesignSystem's String Catalog (ported by the first spec that uses them, Q-7)
  - MacDesignSystem, PadDesignSystem, PhoneDesignSystem (created by the first spec that puts code in them)
  - Release tag and `CHANGELOG.md`
  - Restoring the selected page or tab across launches

## Glossary
| PL | EN | Meaning |
|---|---|---|
| Aplikacja pokazowa | Showcase app | ShowcasePhone, ShowcasePad or ShowcaseMac; the manual verification surface of DesignKit |
| Sekcja | Section | A sidebar group: Foundations or an atomic level |
| Strona | Page | One sidebar entry and its detail |
| Strona komponentu | Component page | A page with the tabs Playground, Variants, Configuration |
| Plac zabaw | Playground | Live preview with controls and a code snippet |
| Warianty | Variants | Every variant side by side, light and dark |
| Konfiguracja | Configuration | Properties and component tokens of the page's subject |
| Bramka | Gate | `scripts/gate.sh`: lint and every build of the repo |

## User stories
- US-1 As a feature developer I want to import DesignKit and DesignSystem and use the fundamentals so that Cores and Views of HomeBudgetApps can be written against them.
- US-2 As a DesignKit developer I want a showcase page model so that each later component adds one page and nothing else.
- US-3 As a reviewer I want each showcase app to launch and navigate on its platform so that manual ACs of later specs have a place to be checked.
- US-4 As a developer or agent I want one gate command so that every slice is checked the same way, cheaply.

## Screens & navigation
### Showcase window (every app)
- Purpose: browse pages by section. Content: a `NavigationSplitView` with a sidebar and a detail.
- Sidebar: sections in this order: Foundations, Atoms, Molecules, Organisms, Templates; every section always shown; pages within a section sorted by title; a section without pages shows one non-selectable row "No pages yet".
- Detail: the selected page; with nothing selected, a native empty state "Select a page" with the message "Choose a page in the sidebar."
- States: no selection, page selected. No loading or error states.
- One window per app (BR-5), so the playground environment is the app's.
- HIG per platform:
  - iPhone: the split view collapses to a stack; launches on the sidebar, a page pushes, Back returns.
  - iPad: sidebar and detail side by side in landscape; in portrait the sidebar is toggled with the system sidebar button; launches with no selection.
  - Mac: one window with sidebar and detail, the system sidebar toggle in the toolbar, no New Window command; launches with no selection.
- Entry: app launch. No routes, slots or links to other modules.

### Component page
- Purpose: show one subject (a component, or the page model itself in Page anatomy) through three tabs.
- A segmented picker in the detail toolbar: Playground, Variants, Configuration.
- When the page opens: Playground selected, every page control at its default; the environment keeps its values (BR-9).
- Playground, top to bottom:
  - Preview: the subject rendered with the current control values and the current Appearance, on the system background of that appearance
  - Controls: one control per configuration property and per data field, defined by the page
  - Environment: the shared playground controls; in this spec only Appearance (System, Light, Dark; default System)
  - Code: the live snippet of what the preview renders (`DK.{Name}(…)` on component pages), a valid Swift expression, selectable, monospaced
- Variants: one row per variant declared by the page, each with a light and a dark rendering side by side, each on the system background of its appearance, labeled with the variant name.
- Configuration: Properties (Name, Type, Default) and Component tokens (Token, Alias chain); a section with no entries shows "None".

### Page anatomy (Foundations)
- Purpose: the reference page that shows and explains the page model, built on it.
- Subject: a sample text.
- Playground: control "Sample text" (text field, default from Copy); preview shows the text; snippet `Text("{sample text}")` with `\` and `"` escaped as `\\` and `\"`; an empty text gives an empty preview and `Text("")`.
- Variants: "Short" and "Long", texts from Copy; Long wraps onto at least three lines in each column at the app's launch window size.
- Configuration: one property `sampleText`, type `String`, default as above; Component tokens "None".
- Each tab starts with a one-line description of what that tab holds on every component page (Copy).

## Data
### DesignKit (Foundation only, public)
- `DK`: namespace enum.
- `DK.ViewState<Content>`: `idle`, `loading`, `loaded(Content)`, `edgeCase(DK.EdgeCase)`; `Equatable` and `Sendable` when `Content` is.
- `DK.EdgeCase`: `icon: DK.Icon` (Q-4), `title: String`, `message: String`, `actions: [DK.ActionButton]` (default `[]`); `Equatable`, `Sendable`.
- `DK.ActionButton`: `id: String` (init parameter `id: String? = nil`, stored as `id ?? title`), `title: String`, `role: Role?` (default `nil`), `state: State` (default `.normal`), `action: @MainActor () async -> Void`; `Equatable` (ignores `action`), `Sendable`, `Identifiable`.
  - `Role`: `primary`, `destructive`, `cancel`. `State`: `disabled`, `loading`, `normal`.
- `DK.Alert`: `title: String`, `message: String`, `actions: [DK.ActionButton]`; `Equatable`, `Sendable`.
- `DK.Tone`: `neutral`, `info`, `success`, `warning`, `critical`; `CaseIterable`, `Equatable`, `Sendable`.
- `DK.Option<Value: Hashable & Sendable>`: `value: Value`, `title: String`, `id` = `value`; `Equatable`, `Sendable`, `Identifiable`.
- `DK.Icon`: `symbol(String)`, `image(Data)`, `monogram(String, DK.AccentTint)`; `Equatable`, `Sendable`.
- `DK.AccentTint`: `brand`, `info`, `success`, `warning`, `critical`; `CaseIterable`, `Equatable`, `Sendable`.
- `DK.TextSize`: raw `Int` percent: `percent85` = 85, `percent100` = 100, `percent115` = 115, `percent130` = 130, `percent150` = 150, `percent175` = 175, `percent200` = 200; `CaseIterable`, `Equatable`, `Sendable`.

### DesignSystem (SwiftUI)
- `DS`: public namespace enum.

### Showcase (`DemoApps/Shared/`)
- Section: `foundations`, `atoms`, `molecules`, `organisms`, `templates`, with titles.
- Page: `id` (stable, unique), `title`, `section`, and a content view that is either a single view or the component page's three tabs.
- Component page content: Playground (preview, page controls with defaults, snippet), Variants (named views), Configuration (properties `[name, type, default]`, tokens `[token, alias chain]`).
- Playground environment: `appearance` (`system`, `light`, `dark`), shared by every page for the app's session.
- Catalog: the shared pages plus the app's own platform pages from `DemoApps/{Phone,Pad,Mac}/`.

## Rules
- BR-1 (no resources superseded by base-molecules BR-12) `Package.swift`: swift-tools-version 6.2; platforms iOS 26 and macOS 26; `defaultLocalization: "pl"`; products and targets `DesignKit` (no dependencies) and `DesignSystem` (depends on `DesignKit`, no resources); no other targets, no test targets, no external dependencies.
- BR-2 Removed (Q-7).
- BR-3 The ported types keep the FinanceTracker public API exactly as in Data, only moved: `DesignKitUI` → `DesignSystem`; the one change is `DK.EdgeCase.symbol: String` → `icon: DK.Icon` (Q-4). Each is ported by copying its FinanceTracker file; the copy differs only by Q-4 and SwiftLint formatting (Q-9). No component, gallery, theme, token or internal helper code is ported (Q-7).
- BR-4 Platform design-system targets are not created by this spec (SwiftPM has no empty targets; architecture §3).
- BR-5 `DemoApps/project.yml` generates `DemoApps/Showcase.xcodeproj` (untracked) with three app targets and schemes:
  - ShowcasePhone: iOS 26, iPhone only, sources `Shared/` + `Phone/`, bundle id `com.sumara.designsystem.showcase.phone`
  - ShowcasePad: iOS 26, iPad only, one scene (`UIApplicationSupportsMultipleScenes` NO), sources `Shared/` + `Pad/`, bundle id `com.sumara.designsystem.showcase.pad`
  - ShowcaseMac: macOS 26, a single `Window` scene, sources `Shared/` + `Mac/`, bundle id `com.sumara.designsystem.showcase.mac`
  - bundle id prefix `com.sumara.designsystem.showcase` (Q-5)
  - each depends on the local package (`..`), products DesignKit and DesignSystem; Swift 6 mode, strict concurrency complete; generated Info.plist; no development team, so the public repo builds anywhere: the iOS apps build and run on the simulator (Q-8), ShowcaseMac is signed to run locally
- BR-6 Showcase copy is English literals in `DemoApps/` (DesignKit CLAUDE.md › Copy); the showcase apps have no String Catalog.
- BR-7 Until `mds` exists, the showcase uses native controls, system text styles and default system spacing only: no literal styling. `.swiftlint.yml`'s `no_literal_styling` includes `DemoApps/` Swift files (Q-6).
- BR-8 Adding a page is one new file in `DemoApps/Shared/` (or a platform folder) plus one catalog entry; no change to the sidebar, detail or page model.
- BR-9 Appearance applies only to the Playground preview; Variants always show light and dark; the app chrome follows the system. Each rendering sits on the system background of its own appearance.
- BR-10 The Page anatomy page is the only page this spec adds (Q-1).
- BR-11 `scripts/gate.sh` runs from any directory, in this order, stopping at the first failure (Q-3); Swift warnings fail every build (Q-10):
  1. `swiftlint lint --strict --quiet` (whole repo, `DemoApps/` included)
  2. `xcrun swift build --build-system swiftbuild -Xswiftc -warnings-as-errors`
  3. `xcodebuild -scheme DesignSystem -destination 'generic/platform=iOS' build SWIFT_TREAT_WARNINGS_AS_ERRORS=YES`
  4. `xcodegen generate` in `DemoApps/`
  5. builds of ShowcasePhone and ShowcasePad (`generic/platform=iOS Simulator`) and ShowcaseMac (`platform=macOS`), each with `SWIFT_TREAT_WARNINGS_AS_ERRORS=YES`
  - It is this repo's gate in `implement-increment` (Q-11). The first slice changes the DesignKit CLAUDE.md › Commands build lines to the forms of steps 2, 3 and 5; the slice that adds the script adds the gate line. The first slice's baseline is a clean `git status` (Q-12).
- BR-12 Gate output: all tool output to one log file (default in `$TMPDIR`, or the path given as the first argument); the terminal shows one line per step (name, pass or fail), and on failure the step's `error:` lines (at most 20), the log path, exit status non-zero. A missing tool (`swiftlint`, `xcodegen`, `xcodebuild`) fails step 0 with its name, before any step runs.

## Copy
Showcase only, English (BR-6). Keys identify the element; they aren't catalog keys.
| Key | pl | en |
|---|---|---|
| showcase.sidebar.foundations | — | Foundations |
| showcase.sidebar.atoms | — | Atoms |
| showcase.sidebar.molecules | — | Molecules |
| showcase.sidebar.organisms | — | Organisms |
| showcase.sidebar.templates | — | Templates |
| showcase.sidebar.emptySection | — | No pages yet |
| showcase.detail.emptyTitle | — | Select a page |
| showcase.detail.emptyMessage | — | Choose a page in the sidebar. |
| showcase.page.playground | — | Playground |
| showcase.page.variants | — | Variants |
| showcase.page.configuration | — | Configuration |
| showcase.playground.controls | — | Controls |
| showcase.playground.environment | — | Environment |
| showcase.playground.code | — | Code |
| showcase.playground.appearance | — | Appearance |
| showcase.playground.appearanceSystem | — | System |
| showcase.playground.appearanceLight | — | Light |
| showcase.playground.appearanceDark | — | Dark |
| showcase.variants.light | — | Light |
| showcase.variants.dark | — | Dark |
| showcase.configuration.properties | — | Properties |
| showcase.configuration.tokens | — | Component tokens |
| showcase.configuration.name | — | Name |
| showcase.configuration.type | — | Type |
| showcase.configuration.default | — | Default |
| showcase.configuration.token | — | Token |
| showcase.configuration.aliasChain | — | Alias chain |
| showcase.configuration.none | — | None |
| showcase.anatomy.title | — | Page anatomy |
| showcase.anatomy.playgroundIntro | — | Playground: the live subject, a control for each property and data field, the shared environment and the code it takes. |
| showcase.anatomy.variantsIntro | — | Variants: every variant, in light and dark. |
| showcase.anatomy.configurationIntro | — | Configuration: properties with their defaults, component tokens with their alias chains. |
| showcase.anatomy.sampleText | — | Sample text |
| showcase.anatomy.sampleTextDefault | — | The quick brown fox jumps over the lazy dog |
| showcase.anatomy.short | — | Short |
| showcase.anatomy.shortText | — | Label |
| showcase.anatomy.long | — | Long |
| showcase.anatomy.longText | — | A longer subject wraps across several lines, so the page shows how it behaves when its content needs more room than one line gives. The text keeps its leading alignment and line spacing, and the row grows to fit every line it takes. |

## Acceptance criteria
- AC-1 Given a clean checkout, when `xcrun swift build --build-system swiftbuild -Xswiftc -warnings-as-errors` runs, then it succeeds and the package exposes exactly the products DesignKit and DesignSystem.
- AC-2 Given the package, when gate step 3 runs, then DesignSystem builds for `generic/platform=iOS` with no warnings; its macOS build is covered by AC-1 and AC-4.
- AC-3 Given the repo, when `swiftlint lint --strict --quiet` runs, then it reports no violations, `DemoApps/` included; a literal styling value (e.g. `.padding(8)`) in a `DemoApps/` Swift file is reported by `no_literal_styling`.
- AC-4 Given `DemoApps/` and no development team configured, when `xcodegen generate` runs, then `Showcase.xcodeproj` has the schemes ShowcasePhone, ShowcasePad and ShowcaseMac, each builds for its destination in gate step 5 with no warnings, and the project isn't tracked by git.
- AC-5 Given the package, then `Sources/DesignKit` holds exactly the files `DK.swift` and `DK+{ViewState,EdgeCase,ActionButton,Alert,Tone,Option,Icon,AccentTint,TextSize}.swift`, and `Sources/DesignSystem` exactly `DS.swift`, no subfolders and no resources.
- AC-6 Given a clean repo, when `scripts/gate.sh` runs, then every step prints pass and it exits 0.
- AC-7 Given a lint violation, a compile error or a Swift warning, when `scripts/gate.sh` runs, then it stops at that step, prints fail with the step name, at most 20 `error:` lines and the log path, runs no later step and exits non-zero.
- AC-8 Given `xcodegen` isn't installed, when `scripts/gate.sh` runs, then it fails before step 1, naming the missing tool.
- AC-9 Given ShowcasePhone on an iPhone simulator, when it launches, then the sidebar shows Foundations, Atoms, Molecules, Organisms, Templates in that order, Foundations lists Page anatomy, the other sections show "No pages yet", tapping Page anatomy pushes it and Back returns. (manual)
- AC-10 Given ShowcasePad on an iPad simulator in landscape, when it launches, then sidebar and the "Select a page" empty state show side by side; selecting Page anatomy shows it in the detail; in portrait the sidebar button shows and hides the sidebar. (manual)
- AC-11 Given ShowcaseMac, when it launches, then one window shows the sidebar and the "Select a page" empty state; selecting Page anatomy shows it; the toolbar sidebar toggle hides and shows the sidebar; the File menu has no New Window command. (manual)
- AC-12 Given Page anatomy open on any app, when it opens, then the toolbar picker shows Playground, Variants, Configuration with Playground selected, and each tab shows its content per Screens & navigation. (manual)
- AC-13 Given the Playground of Page anatomy, when the sample text is edited, then the preview and the snippet `Text("…")` update on every keystroke; `"` and `\` show as `\"` and `\\` in the snippet; cleared text gives an empty preview and `Text("")`. (manual)
- AC-14 Given the Playground with the system in dark mode, when Appearance is Light, then the preview renders light on a light background while the chrome stays dark; Dark renders it dark; System follows the system; after leaving and reopening the page within the session, Appearance is kept while the tab is Playground and Sample text is its default. (manual)
- AC-15 Given the Variants tab of Page anatomy, then Short and Long each show a light and a dark rendering, each on its own appearance's background, and Long wraps onto at least three lines in each column at the app's launch window size. (manual)
- AC-16 Given the Configuration tab of Page anatomy, then Properties lists, under Name, Type and Default, `sampleText`, `String` and its default, and Component tokens shows "None". (manual)
- AC-17 Given each file of AC-5 and its FinanceTracker `Kits/DesignKit` source (`Sources/DesignKit/`, `Sources/DesignKitUI/` for `DS.swift`), when compared with `git diff --no-index -w`, then the only differences are Q-4 (`symbol: String` → `icon: DK.Icon`) and SwiftLint formatting; checked once in the slice that ports them, since the sources aren't in this repo.
- AC-18 Given the showcase sources, when `DemoApps/` is searched for the Page anatomy page's type name, then exactly two files match: its own file in `DemoApps/Shared/` and the catalog.

## Open questions
- None
