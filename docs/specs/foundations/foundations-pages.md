# Foundations pages
Status: Draft · Repo: DesignKit · Feature: foundations · Module or target: `DemoApps/` · Depends on: foundations/package-and-showcase, foundations/theme-and-tokens

## Goal
The showcase Foundations pages Primitives, Semantic tokens and Component tokens, and the playground controls Theme, Amendment and Text size, so every token can be checked without reading code and every component page can be previewed under any theme, amendment and text size. They are the manual verification surface of theme-and-tokens (its BR-18; theme-and-tokens Q-9).

## Scope
- In:
  - Foundations pages Primitives, Semantic tokens, Component tokens
  - Playground environment controls Theme, Amendment, Text size on every component page
  - Owners updated with the code (BR-7): `docs/architecture.md` §7
- Out:
  - Tokens, themes, the amendment, text size, `mds` APIs and the token inventory (theme-and-tokens)
  - Component pages' Configuration tab reading the inventory (first component spec)

## Glossary
| PL | EN | Meaning |
|---|---|---|
| Inwentarz tokenów | Token inventory | The read-only `@_spi(Showcase)` listing of a theme's primitives, semantic and component tokens (theme-and-tokens BR-14) |
| Środowisko | Environment | The shared playground controls Appearance, Theme, Amendment, Text size |

## User stories
- US-1 As a reviewer I want the showcase to list every primitive and semantic token with its alias chain and to preview any page under a theme, amendment and text size, so that I can check values without reading code.
- US-2 As a reviewer I want to see tokens rendered through the real `mds` resolution, so that a resolver bug shows on the page.

## Screens & navigation
### Primitives (Foundations page, single view)
- Purpose: every primitive with its value. Content, top to bottom: intro line; color families in the order of theme-and-tokens Data, each a wrapping grid of swatches with name and hex; the `accent` swatch labeled as the system accent color; one block per scale (name, unit, every token name with its value).
- Values come from the inventory (BR-1). Swatches render the primitive itself, independent of Appearance.

### Semantic tokens (Foundations page, single view)
- Purpose: every semantic token of the selected theme with its alias chain, rendered.
- Top: the environment controls Theme, Amendment, Text size (BR-2); the content below renders with them.
- Colors, one table per group in the order of Data: token name, alias (`light · dark`, with `@ opacityN` where it applies), the Increase Contrast alias ("same" when it equals the normal pair), and five swatches: Light, Dark, Light increased, Dark increased, Current (BR-1).
- Spacing: name, primitive, a bar of that length. Radius: name, primitive, a rounded square. BorderWidth: name, primitive, a stroked square.
- Motion: name, primitive and milliseconds, a Play button that moves a dot across a track with that token's animation (theme-and-tokens BR-11).
- Typography: the design; one sample line per style at its default weight, with its `fontSize` primitive on macOS; then the body style in each weight; sizes follow Text size (theme-and-tokens BR-6).

### Component tokens (Foundations page, single view)
- Purpose: the rules of the tier and every component token of the session's Theme × Amendment (BR-6) with its chain `component → semantic → primitive`.
- Content: the intro lines (Copy), then one table per component from the inventory (Token, Alias chain); with no component configured, "None".

### Playground environment (every component page)
- Adds, after Appearance: Theme (Standard; default Standard), Amendment (None, Sample; default None), Text size.
- Text size options: macOS the seven `DK.TextSize` steps (default 100 %); iOS and iPadOS System (default), then the twelve Dynamic Type sizes Extra small … Accessibility 5 (Q-1).
- Theme, Amendment and Text size apply to the Playground preview and every Variants rendering; Appearance stays Playground-only (package-and-showcase BR-9).

### HIG per platform
- Mac and iPad in regular width: color tables with one row per token and the columns above.
- iPhone, and iPad in compact width: each color token a stacked row (name, alias line, Increase Contrast line, then the five swatches in one row); swatch grids wrap; no horizontal scrolling (BR-5).
- The app chrome keeps `standard`, the default text size and the system Dynamic Type size (BR-2).

## Data
- Every page value comes from the theme-and-tokens inventory (BR-1); this spec adds no data.

## Rules
- BR-1 The pages take every value and chain from the inventory; none is written in `DemoApps/`; a primitive or token added to a theme shows on them with no showcase change. Exception: the Light, Dark and Current swatches render the token through `Color(mds:)` under the page's theme, Light and Dark with the color scheme forced, Current with the device's color scheme and Increase Contrast; Light increased and Dark increased draw the inventory's primitives, since SwiftUI can't force Increase Contrast.
- BR-2 The environment controls (Theme, Amendment, Text size, Appearance) keep their values for the app's session across pages, like Appearance (package-and-showcase BR-9); Theme × Amendment applies as `theme.amended(by:)`. They apply to the Playground preview, every Variants rendering and the Semantic tokens content; the chrome stays on `.theme(.standard)` and `.chromeTextSize()` (theme-and-tokens BR-8, BR-9).
- BR-3 Text size applies on macOS as `.textSize(_:)` with `.contentTextSize()`; on iOS and iPadOS System applies no override, so the device's Dynamic Type applies, and an explicit size applies `.dynamicTypeSize(_:)` (Q-1).
- BR-4 The pages style only through `mds` (package-and-showcase BR-7 ends with this spec): swatches and the Radius and BorderWidth squares Spacing.xLarge per side, swatch corners Radius.small with a Border.subtle outline of BorderWidth.thin, spacing bars and the motion track Spacing.xSmall thick, the motion dot Spacing.medium; no literal sizes.
- BR-5 In compact width every page fits the width: grids wrap, color tables become stacked rows; regular width keeps tables.
- BR-6 The Component tokens page has no environment controls; it reads the session's Theme × Amendment (BR-2).
- BR-7 The slice that adds the pages updates `docs/architecture.md` §7: Foundations pages Page anatomy, Primitives, Semantic tokens, Component tokens.
- BR-8 Each page is one new file plus one catalog entry (package-and-showcase BR-8).

## Copy
Showcase only, English (package-and-showcase BR-6). Reused: `showcase.configuration.token`, `showcase.configuration.aliasChain`, `showcase.configuration.none`.
| Key | pl | en |
|---|---|---|
| showcase.primitives.title | — | Primitives |
| showcase.primitives.intro | — | Raw values named {family}{step}; a color's step is its CIE L* lightness. Only themes and amendments use them. |
| showcase.primitives.accent | — | System accent color |
| showcase.semantic.title | — | Semantic tokens |
| showcase.semantic.intro | — | Each value aliases a primitive: colors as a light and dark pair with an optional Increase Contrast pair, the rest one primitive. |
| showcase.semantic.colors | — | Colors |
| showcase.semantic.spacing | — | Spacing |
| showcase.semantic.radius | — | Radius |
| showcase.semantic.borderWidth | — | Border width |
| showcase.semantic.motion | — | Motion |
| showcase.semantic.typography | — | Typography |
| showcase.semantic.design | — | Design |
| showcase.semantic.token | — | Token |
| showcase.semantic.alias | — | Alias |
| showcase.semantic.primitive | — | Primitive |
| showcase.semantic.increaseContrast | — | Increase Contrast |
| showcase.semantic.same | — | same |
| showcase.semantic.light | — | Light |
| showcase.semantic.dark | — | Dark |
| showcase.semantic.lightIncreased | — | Light increased |
| showcase.semantic.darkIncreased | — | Dark increased |
| showcase.semantic.current | — | Current |
| showcase.semantic.points | — | {n} pt |
| showcase.semantic.milliseconds | — | {n} ms |
| showcase.semantic.play | — | Play |
| showcase.semantic.sample | — | The quick brown fox jumps over the lazy dog |
| showcase.components.title | — | Component tokens |
| showcase.components.intro1 | — | One configuration per component, read only by that component through @MDS. |
| showcase.components.intro2 | — | Colors, radii, border widths and spacing alias semantic tokens; sizes of the component alone alias primitives. |
| showcase.components.intro3 | — | Text-bound sizes scale with the text size; spacing, radii, border widths and durations don't. |
| showcase.playground.theme | — | Theme |
| showcase.playground.themeStandard | — | Standard |
| showcase.playground.amendment | — | Amendment |
| showcase.playground.amendmentNone | — | None |
| showcase.playground.amendmentSample | — | Sample |
| showcase.playground.textSize | — | Text size |
| showcase.playground.textSizePercent | — | {n} % |
| showcase.playground.textSizeSystem | — | System |
| showcase.playground.dynamicType | — | Extra small · Small · Medium · Large · Extra large · Extra extra large · Extra extra extra large · Accessibility 1 … Accessibility 5 |

## Acceptance criteria
- AC-1 Given the repo, when `scripts/gate.sh` runs, then every step passes, `no_literal_styling` included on the new pages.
- AC-2 Given the Primitives page on any app, then every family, step and hex and every scale with its tokens, `fontSize` included, equals theme-and-tokens Data, and `accent` is labeled "System accent color". (manual)
- AC-3 Given the Semantic tokens page with Standard and no amendment, then every color token's alias and its Light and Dark swatches equal theme-and-tokens Data, and Spacing, Radius, BorderWidth, Motion and Typography (design, and the macOS `fontSize` per style) list its aliases. (manual)
- AC-4 Given the Semantic tokens page, when Amendment is Sample, then Background.page, Background.brand, Foreground.brand, Spacing.large and the typography design change to the values of theme-and-tokens Data (sample text in serif, Play buttons tinted pink38), and every other token stays unchanged; None restores them. (manual)
- AC-5 Given the Component tokens page, then it shows the three intro lines and "None". (manual)
- AC-6 Given ShowcaseMac, when Text size goes from 100 % to 200 %, then each typography sample doubles from its `fontSize` primitive, the Play buttons switch to extraLarge controls, spacing bars keep their length, and the sidebar and toolbar keep their size. (manual)
- AC-7 Given ShowcasePhone or ShowcasePad with Text size System, when the simulator's Dynamic Type changes, then typography samples and the preview scale with it; when Text size goes from Large to Accessibility 5, they grow like system text, spacing bars keep their length, and the simulator's setting no longer changes them. (manual)
- AC-8 Given the Playground of Page anatomy, when Amendment is Sample, then the preview and both Variants renderings show the sample text in serif while the chrome stays unchanged; the edited sample text is kept. (manual)
- AC-9 Given the Motion row quick, when Play is tapped, then the dot moves over 150 ms; with Reduce Motion on, it jumps without animation. (manual)
- AC-10 Given Theme, Amendment and Text size set on one page, when another component page opens within the session, then they keep their values. (manual)
- AC-11 Given the Semantic tokens page, then every color token's Increase Contrast alias and its two increased swatches equal theme-and-tokens Data, "same" where Data has no `+` pair. (manual)
- AC-12 Given the Semantic tokens page on ShowcaseMac and on an iOS simulator, when the system's Increase Contrast is turned on, then the Current swatches switch to the `+` pairs of theme-and-tokens Data (e.g. Foreground.secondary to slate25 in light) and back when it is off. (manual)
- AC-13 Given ShowcasePhone, and ShowcasePad in compact width, then every Foundations page fits the width with stacked color rows and wrapping swatch grids, without horizontal scrolling. (manual)

## Open questions
- None
