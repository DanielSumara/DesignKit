# Theme and tokens — implementation plan
Spec: DesignKit/docs/specs/foundations/theme-and-tokens.md
Repo: DesignKit
Status: In progress
Run base: 4a3b70d3a19779a69dc2f3faf930b91e4ba05ffd

## Slices
### S1 — DesignKit: primitive tier
- ACs: —
- Area: `Sources/DesignKit`
- Depends on: —
- Skills: design-system
- Review: full
- Builds: `package` primitives in `Sources/DesignKit/Primitives/`, one type per file: color primitive type (sRGB hex, `accent` as system) with the ramps of Data (gray, slate, blue, green, orange, red, sand, pink); opacity primitive; scales `space`, `size`, `radius`, `stroke`, `duration`, `opacity`, `fontSize` with exactly the Data tokens (BR-1, BR-2); a way for DesignSystem to enumerate them for the inventory (S5)
- Done when: names and values match the Data tables; lint clean; DesignKit builds for macOS and iOS (`DK.TextSize` untouched)
- Manual ACs: —

### S2 — DesignSystem: semantic tier, `standard`, amendment, components shell
- ACs: AC-2, AC-3, AC-19
- Area: `Sources/DesignSystem/Theme/`, `Sources/DesignSystem/Tokens/`, `docs/architecture.md`, `CLAUDE.md`
- Depends on: S1
- Skills: design-system
- Review: full
- Builds: `DS.Theme` (`id`, `standard`, `amended(by:)`), `DS.Theme.Amendment` (`sample`), `DS.Theme.SemanticTokens` with Colors (light/dark alias with optional opacity, Increase Contrast pair), Spacing, Typography (`Design`, `Weight`, macOS `fontSize` ramp), Radius, BorderWidth, Motion; `DS.Theme.Components` and its scaling list, both empty; opaque values (Q-15). Ported from FinanceTracker `Kits/DesignKit/Sources/DesignKitUI/Tokens/*` and `Theme/{DS+Theme, DS+Theme+Standard, DS+Theme+Amendment, DS+Theme+Components, DS+Theme+Components+Scaling}.swift`. Docs per BR-17: `docs/architecture.md` §3, §4, §5, §9 removed; `CLAUDE.md` SPI exception
- Done when: AC-2 and AC-3 fault injections compile-fail as specified, then removed; AC-19 read; lint clean; DesignSystem builds for macOS and iOS
- Manual ACs: —

### S3 — DesignSystem: environment, text size, `@MDS`, reader, theme modifiers
- ACs: —
- Area: `Sources/DesignSystem/Theme/`, `Sources/DesignSystem/Support/`
- Depends on: S2
- Skills: design-system
- Review: full
- Builds: environment values for theme and text size; `@MDS` and `@MDS(\.{component})`; reader `mds(color:)`, `mds(spacing:)`, `mds(radius:)`, `mds(borderWidth:)`, `mds(font:)`, `mds(font:_:)`, `mds(motion:)` (BR-6, BR-11, BR-12); token color resolution (BR-5); `DK.TextSize` scale; `View.themeRoot(_:)`, `.theme(_:)`, `.textSize(_:)`, `.chromeTextSize()`, `.contentTextSize()` (BR-8, BR-9); platform differences inside DesignSystem without AppKit or UIKit (BR-13). Ported from FinanceTracker `Theme/{EnvironmentValues+Theme, MDS, DS+Theme+Reader, DS+Theme+TokenColor, View+TextSize, View+Theme}.swift` and `Support/DK.TextSize+Scale.swift`
- Done when: lint clean; DesignSystem builds for macOS and iOS
- Manual ACs: —

### S4 — DesignSystem: `Color(mds:)` and `mds` view modifiers
- ACs: AC-4, AC-5
- Area: `Sources/DesignSystem/Theme/`
- Depends on: S3
- Skills: design-system
- Review: diff-only
- Builds: `Color(mds:)`; modifiers `font(mds:)`, `font(mds:_:)`, `foregroundStyle(mds:)`, `background(mds:)`, `background(mds:cornerRadius:)`, `border(mds:width:cornerRadius:)`, `clipShape(mds:)`, `tint(mds:)`, `padding(mds:)`, `padding(_:mds:)`, `animation(mds:value:)`. Ported from `Theme/{Color+MDS, View+MDS}.swift`
- Done when: AC-4 fault injections as specified; AC-5 `git diff --no-index -w` of every file ported in S2 to S4 shows only BR-4 deviations; lint clean; DesignSystem builds for macOS and iOS
- Manual ACs: —

### S5 — DesignSystem: `@_spi(Showcase)` token inventory
- ACs: AC-6
- Area: `Sources/DesignSystem/Inventory/`
- Depends on: S2
- Skills: design-system
- Review: full
- Builds: `@_spi(Showcase)` read-only inventory for a theme, amended or not: primitives (name, scale, value), semantic tokens (group, name, alias with light/dark, opacity, Increase Contrast pair; Typography design case; macOS styles as `fontSize` primitive), component tokens (empty), in Data order; derived from the themes themselves (BR-14)
- Done when: AC-6 searches (no AppKit or UIKit import in `Sources/DesignSystem`; SPI import only in `DemoApps/`); lint clean; DesignSystem builds for macOS and iOS
- Manual ACs: —

### S6 — Showcase: scene roots
- ACs: AC-1, AC-15
- Area: `DemoApps/Mac/`, `DemoApps/Phone/`, `DemoApps/Pad/`
- Depends on: S4
- Skills: design-system
- Review: diff-only
- Builds: each app's window content carries `.themeRoot(.standard)` and, nearer the content, `.chromeTextSize()` in `ShowcaseMacApp.swift`, `ShowcasePhoneApp.swift`, `ShowcasePadApp.swift`
- Done when: `scripts/gate.sh` passes every step (AC-1); AC-15 search of the three scene roots
- Manual ACs: AC-15

## AC coverage
| AC | Slice | Verified by |
|---|---|---|
| AC-1 | S6 | `scripts/gate.sh` |
| AC-2 | S2 | compile-fail check in `DemoApps/` |
| AC-3 | S2 | compile-fail checks on `standard` |
| AC-4 | S4 | compile-fail and compile checks |
| AC-5 | S4 | `git diff --no-index -w` against FinanceTracker |
| AC-6 | S5 | search of `Sources/DesignSystem` and workspace |
| AC-15 | S6 | manual, plus search of scene roots |
| AC-19 | S2 | reading `docs/architecture.md` and `CLAUDE.md` |

## Manual verification
- AC-15 — run ShowcaseMac: window background FFFFFF in light, 1E1E1E in dark; run ShowcasePhone and ShowcasePad: system backgrounds unchanged; search the three scene roots for `.themeRoot(.standard)` with `.chromeTextSize()` nearer the content

## Out of scope
- Foundations pages and playground Theme, Amendment, Text size controls (foundations/foundations-pages)
- Components, `DK.Tone` and `DK.AccentTint` color mappings, `sceneContentSize`, other themes (spec Scope › Out)

## Progress
| Slice | Status | Base | Head | Review |
|---|---|---|---|---|
| S1 | Pending | — | — | — |
| S2 | Pending | — | — | — |
| S3 | Pending | — | — | — |
| S4 | Pending | — | — | — |
| S5 | Pending | — | — | — |
| S6 | Pending | — | — | — |

## Open questions
- None
