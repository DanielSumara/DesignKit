# Foundations pages — implementation plan
Spec: DesignKit/docs/specs/foundations/foundations-pages.md
Repo: DesignKit
Status: In progress
Run base: c79b634

## Slices
### S1 — DesignSystem: inventory resolution
- ACs: AC-15
- Area: `Sources/DesignSystem/Inventory/`
- Depends on: —
- Skills: design-system
- Review: full
- Builds: `@_spi(Showcase)` extensions in `DS.Theme.Inventory+*.swift`: key path per semantic entry (colors, Spacing, Radius, BorderWidth, Motion, typography styles; none for design), `Typography.Weight` key paths (regular, medium, semibold, bold), `Color(inventory:)` for a primitive entry or `ColorReference`, `accent` as the system accent color; the unmapped-token check naming the token
- Done when: lint clean; package and iOS builds pass; a semantic token or weight left out fails to compile or stops the inventory naming it; no non-SPI API change; no primitive leaves the SPI; `DemoApps/` search for `DS.Theme.SemanticTokens` key paths, `Color(red:`, `Color(hex:` empty
- Manual ACs: —

### S2 — DemoApps: session environment and playground controls
- ACs: AC-8
- Area: `DemoApps/Shared/` (`PlaygroundEnvironment.swift`, `PlaygroundLayout.swift`, `ComponentPageView.swift`, `ShowcaseRoot.swift`; new `EnvironmentControls`, `ShowcaseTheme`, `ShowcaseAmendment`, `ShowcaseTextSize` files)
- Depends on: —
- Skills: design-system
- Review: full
- Builds: session-wide Theme, Amendment and Text size state kept across pages beside Appearance; reusable environment controls view (full set, and Theme + Amendment only); an environment-applying modifier for content (`theme.amended(by:)`, nested `.theme(_:)`, `.textSize` with `.contentTextSize()` on macOS, `.dynamicTypeSize` on iOS, System = no override); Playground and Variants wired to it; chrome stays `.themeRoot(.standard)` and `.chromeTextSize()`; copy keys `showcase.playground.*` (theme, amendment, textSize, dynamicType) in the catalog
- Done when: lint clean; `ShowcaseMac`, `ShowcasePhone`, `ShowcasePad` build; Appearance remains Playground-only
- Manual ACs: AC-8

### S3 — DemoApps: Primitives page and architecture §7
- ACs: AC-2, AC-14
- Area: `DemoApps/Shared/PrimitivesPage.swift`, `DemoApps/Shared/Catalog.swift`, `DemoApps/Shared/` String Catalog, `docs/architecture.md` §7
- Depends on: S1
- Skills: design-system
- Review: diff-only
- Builds: `PrimitivesPage`; catalog entry; `showcase.primitives.*` copy; §7 listing Foundations pages Page anatomy, Primitives, Semantic tokens, Component tokens
- Done when: lint clean; three Showcase apps build; page is one file plus one catalog entry; content sizes through `mds` per BR-4; AC-14 checked
- Manual ACs: AC-2

### S4 — DemoApps: Semantic tokens page, color tables
- ACs: AC-11, AC-12
- Area: `DemoApps/Shared/SemanticTokensPage.swift` and color views beside it, `DemoApps/Shared/Catalog.swift`, String Catalog
- Depends on: S1, S2
- Skills: design-system
- Review: full
- Builds: `SemanticTokensPage` with the environment controls, intro, Colors tables (regular width) and stacked rows (compact width), five swatches per token (Light, Dark, Current via `Color(mds:)`, increased pair via `Color(inventory:)`), "same" for tokens without a `+` pair; `showcase.semantic.*` copy used so far; catalog entry
- Done when: lint clean; three Showcase apps build
- Manual ACs: AC-11, AC-12

### S5 — DemoApps: Semantic tokens page, remaining groups
- ACs: AC-3, AC-4, AC-6, AC-7, AC-9
- Area: `DemoApps/Shared/SemanticTokensPage.swift` and group views beside it, String Catalog
- Depends on: S4
- Skills: design-system
- Review: diff-only
- Builds: Spacing, Radius, BorderWidth, Motion (Play button, dot on track, Reduce Motion jump), Typography (styles with `fontSize` on macOS, body in four weights) sections on the same page; remaining `showcase.semantic.*` copy
- Done when: lint clean; three Showcase apps build
- Manual ACs: AC-3, AC-4, AC-6, AC-7, AC-9

### S6 — DemoApps: Component tokens page, final checks
- ACs: AC-1, AC-5, AC-10, AC-13
- Area: `DemoApps/Shared/ComponentTokensPage.swift`, `DemoApps/Shared/Catalog.swift`, String Catalog
- Depends on: S2, S5
- Skills: design-system
- Review: diff-only
- Builds: `ComponentTokensPage` with Theme and Amendment controls, three intro lines, one table per inventory component or "None"; `showcase.components.*` copy; catalog entry
- Done when: `scripts/gate.sh` passes with every step, `no_literal_styling` included on the new pages
- Manual ACs: AC-5, AC-10, AC-13

## AC coverage
| AC | Slice | Verified by |
|---|---|---|
| AC-1 | S6 | `scripts/gate.sh` |
| AC-2 | S3 | manual: Primitives page, all apps |
| AC-3 | S5 | manual: Semantic tokens, Standard |
| AC-4 | S5 | manual: Amendment Sample |
| AC-5 | S6 | manual: Component tokens page |
| AC-6 | S5 | manual: ShowcaseMac, Text size 100 % → 200 % |
| AC-7 | S5 | manual: ShowcasePhone, ShowcasePad |
| AC-8 | S2 | manual: Page anatomy Playground |
| AC-9 | S5 | manual: Motion quick, Reduce Motion |
| AC-10 | S6 | manual: Semantic tokens ↔ Page anatomy ↔ Component tokens |
| AC-11 | S4 | manual: increased swatches |
| AC-12 | S4 | manual: Increase Contrast on macOS and iOS |
| AC-13 | S6 | manual: ShowcasePhone, ShowcasePad compact |
| AC-14 | S3 | reading, once |
| AC-15 | S1 | search and build check, once |

## Manual verification
- AC-2 — ShowcaseMac and an iOS simulator: Primitives vs theme-and-tokens Data; `accent` labeled "System accent color"
- AC-3, AC-4 — ShowcaseMac: Semantic tokens with Standard, then Amendment Sample, then None
- AC-5 — any Showcase app: Component tokens shows Theme, Amendment, three intro lines, "None"
- AC-6 — ShowcaseMac: Text size 100 % → 200 %
- AC-7 — ShowcasePhone or ShowcasePad: System with Dynamic Type changes, Large → Accessibility 5
- AC-8 — any Showcase app: Page anatomy Playground with Amendment Sample
- AC-9 — any Showcase app: Motion quick Play, with Reduce Motion on
- AC-10 — any Showcase app: values shared across Semantic tokens, Page anatomy, Component tokens
- AC-11 — ShowcaseMac: increased swatches vs Data, "same" where none
- AC-12 — ShowcaseMac and an iOS simulator: system Increase Contrast on and off
- AC-13 — ShowcasePhone and ShowcasePad in compact width: every Foundations page

## Out of scope
- Tokens, themes, the amendment, text size, `mds` APIs and the inventory's entries (theme-and-tokens)
- Component pages' Configuration tab reading the inventory (first component spec)

## Progress
| Slice | Status | Base | Head | Review |
|---|---|---|---|---|
| S1 | Done | ea21282 | a190e0f | 2 fixed / 0 rejected |
| S2 | Done | 9ee1db3 | 2eacc68 | 0 fixed / 0 rejected |
| S3 | Done | 663fc82 | 0123114 | 0 fixed / 0 rejected |
| S4 | Done | 88ed490 | db78e1c | 2 fixed / 0 rejected |
| S5 | Done | e8cc599 | a0ff674 | 0 fixed / 0 rejected |
| S6 | Done | 7e54be2 | 72d6865 | 0 fixed / 0 rejected |

## Open questions
- None
