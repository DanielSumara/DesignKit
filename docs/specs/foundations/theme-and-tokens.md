# Theme and tokens
Status: Draft · Repo: DesignKit · Feature: foundations · Module or target: DesignKit, DesignSystem, `DemoApps/` scene roots · Depends on: foundations/package-and-showcase

## Goal
The styling mechanics every component and screen builds on: the three token tiers, the `standard` theme and its sample amendment, text size, and the `mds` access APIs (`@MDS`, the reader, `Color(mds:)`, view modifiers), ported from FinanceTracker and made cross-platform, plus the read-only token inventory the showcase reads. The Foundations showcase pages and the playground Theme, Amendment and Text size controls are foundations/foundations-pages, which verifies this spec's rendered behavior (Q-1, Q-9).

## Scope
- In:
  - Primitive tier in DesignKit (`package`): color ramps, the system `accent`, scales `space`, `size`, `radius`, `stroke`, `duration`, `opacity`, `fontSize` (Q-11)
  - Semantic tier: Colors (Background, OnBackground, Foreground, Border, Focus) with an Increase Contrast pair each (Q-6), Spacing, Typography, Radius, BorderWidth, Motion
  - Component tier `DS.Theme.Components` and its text-bound scaling list, both empty until the first component spec
  - `DS.Theme` with `standard`; `DS.Theme.Amendment` with `sample`; `amended(by:)`
  - Text size: `DK.TextSize` on macOS, Dynamic Type on iOS and iPadOS (Q-2)
  - `.themeRoot(_:)`, `.theme(_:)`, `.textSize(_:)`, `.chromeTextSize()`, `.contentTextSize()`, `@MDS`, the `mds(…)` reader, `Color(mds:)`, the `mds` view modifiers
  - `@_spi(Showcase)` token inventory (Q-5)
  - Showcase scene roots: `.themeRoot(.standard)` and `.chromeTextSize()` on each app's window content
  - Owners updated with the code (BR-17): `docs/architecture.md` §3, §4, §5, §9; `DesignKit/CLAUDE.md` SPI exception
- Out:
  - Foundations pages Primitives, Semantic tokens, Component tokens; playground controls Theme, Amendment, Text size (foundations/foundations-pages, Q-9)
  - Every component and its configuration, the FinanceTracker ones included (`components/…` specs); the sample amendment's component override (BR-10)
  - `DK.Tone` and `DK.AccentTint` color mappings, `foregroundStyle(tone:)` (first component spec that uses them)
  - `sceneContentSize` and sheet sizing (first spec with a sheet)
  - Themes other than `standard`; amendments defined outside the package
  - DesignSystem's String Catalog: no copy in this spec

## Glossary
| PL | EN | Meaning |
|---|---|---|
| Prymityw | Primitive | A raw value (`blue43`, `space16`); only themes and amendments use it |
| Token semantyczny | Semantic token | A purpose (`Background.infoSubtle`) aliasing primitives |
| Token komponentu | Component token | One component's configuration value, aliasing a semantic token or a size primitive |
| Alias | Alias | A reference to a token of the tier below, never a literal |
| Motyw | Theme | A complete mapping semantic → primitive and component → semantic |
| Poprawka | Amendment | Overrides of some tokens of one base theme |
| Rozmiar tekstu | Text size | `DK.TextSize`, the macOS content scale 85–200 % |
| Rozmiar związany z tekstem | Text-bound size | A component size that sits beside or holds text and scales with it |

## User stories
- US-1 As a feature developer I want to style views by purpose (`.foregroundStyle(mds: \.secondary)`) so that screens restyle with the theme and an unknown or misplaced token fails to compile.
- US-2 As a DesignKit developer I want a component configuration tier read through `@MDS(\.{component})` so that each component has named, overridable values.
- US-3 As a Mac user I want the app's text size preference to scale content text, and as an iPhone or iPad user I want the system Dynamic Type setting to, so that I read comfortably.
- US-4 As a user I want colors to follow light and dark mode and animations to honor Reduce Motion.
- US-5 Moved to foundations-pages (Q-9).
- US-6 As a maintainer I want an amendment to restyle part of a theme without copying it.

## Screens & navigation
No screens; the showcase pages are foundations-pages (Q-9).

### HIG per platform
- Mac: `Background.page` is the window background (Q-3); content text and controls scale with Text size, toolbar and sidebar chrome don't.
- iPhone and iPad: system backgrounds kept (Q-3); text follows Dynamic Type like system text (Q-2).
- Brand tint follows the system accent color: the user's accent on macOS, the app's AccentColor (system blue without one) on iOS (Q-4).

## Data
### Primitives (DesignKit, `package`)
Colors (step ≈ CIE L*), sRGB hex:
| Family | Steps |
|---|---|
| gray | gray100 FFFFFF · gray11 1E1E1E |
| slate | slate97 F5F5F7 · slate94 EEEEF0 · slate93 EBEBEE · slate84 D1D1D6 · slate73 B4B4B9 · slate66 A1A1A6 · slate58 8B8B90 · slate53 7E7E83 · slate47 6E6E73 · slate43 656569 · slate42 636366 · slate37 57575C · slate25 3C3C40 · slate22 353538 · slate19 2E2E31 · slate17 29292B · slate11 1D1D1F |
| blue | blue94 E7F0FD · blue76 8DBEFF · blue69 66AAFF · blue43 0A60D6 · blue40 0058D0 · blue35 0B4DB3 · blue16 10284A |
| green | green95 E5F4EA · green80 7EDB98 · green74 3FCF6A · green45 1E7B36 · green43 1A7431 · green37 17652C · green17 0F2F1A |
| orange | orange96 FFF1D9 · orange83 FFC56B · orange78 FFB23E · orange74 F5A524 · orange43 A64B00 · orange36 874200 · orange16 382505 |
| red | red94 FDE9E9 · red75 FF9D96 · red68 FF7F78 · red44 D0021B · red42 C9001B · red35 A8001A · red13 3D1316 |
| sand | sand94 F6EEDC · sand15 2B2418 |
| pink | pink71 F48FB1 · pink38 AD1457 |
| system | accent: the system accent color (Q-4) |

Scales:
| Scale | Tokens |
|---|---|
| space (pt) | space2 · space4 · space8 · space12 · space16 · space24 · space32 · space48 |
| size (pt) | size12 · size16 · size20 · size24 |
| radius (pt) | radius4 · radius8 · radius12 · radius20 |
| stroke (pt) | stroke1 · stroke2 · stroke3 |
| duration (ms) | duration150 · duration250 · duration400 |
| opacity (%) | opacity15 · opacity20 · opacity30 |
| fontSize (pt at 100 %) | fontSize10 · fontSize11 · fontSize12 · fontSize13 · fontSize15 · fontSize17 · fontSize22 · fontSize26 (Q-11) |

### Semantic tokens (DesignSystem, `DS.Theme.SemanticTokens`; public names, opaque values)
Colors, `standard` (one primitive = same in light and dark; `@` = with opacity; `+` = the Increase Contrast pair, light · dark; no `+` = the normal pair, Q-6):
| Group | Token → light · dark + increased |
|---|---|
| Background | page gray100 · gray11; surface slate97 · slate17; surfaceRaised slate93 · slate22; brand accent; brandSubtle accent@opacity15 · accent@opacity20 + accent@opacity20 · accent@opacity30; neutral slate47 · slate42 + slate37; neutralSubtle slate94 · slate19; info blue43 + blue35; infoSubtle blue94 · blue16; success green45 + green37; successSubtle green95 · green17; warning orange74 + orange83; warningSubtle orange96 · orange16; critical red44 + red35; criticalSubtle red94 · red13 |
| OnBackground | brand gray100; brandSubtle slate11 · slate97; neutral gray100; neutralSubtle slate25 · slate84 + slate11 · slate97; info gray100; infoSubtle blue35 · blue76 + blue16 · blue94; success gray100; successSubtle green37 · green80 + green17 · green95; warning slate11; warningSubtle orange36 · orange83 + orange16 · orange96; critical gray100; criticalSubtle red35 · red75 + red13 · red94 |
| Foreground | primary slate11 · slate97 + slate11 · gray100; secondary slate37 · slate73 + slate25 · slate84; tertiary slate43 · slate66 + slate37 · slate73; disabled slate66 · slate47 + slate53 · slate58; brand accent; info blue40 · blue69 + blue35 · blue76; success green43 · green74 + green37 · green80; warning orange43 · orange78 + orange36 · orange83; critical red42 · red68 + red35 · red75 |
| Border | subtle slate84 · slate25 + slate53 · slate58; strong slate53 · slate58 + slate37 · slate73; brand accent; info blue40@opacity30 · blue69@opacity30 + blue40 · blue69; success green43@opacity30 · green74@opacity30 + green43 · green74; warning orange43@opacity30 · orange78@opacity30 + orange43 · orange78; critical red42 · red68 + red35 · red75; criticalSubtle red42@opacity30 · red68@opacity30 + red42 · red68 |
| Focus | ring accent@opacity30 + accent |

Other groups, `standard`:
- Spacing: xxSmall space2 · xSmall space4 · small space8 · medium space16 · large space24 · xLarge space32 · xxLarge space48
- Radius: small radius4 · medium radius8 · large radius12 · xLarge radius20
- BorderWidth: thin stroke1 · medium stroke2 · thick stroke3
- Motion: quick duration150 · standard duration250 · slow duration400
- Typography: `design`, a `DS.Theme.SemanticTokens.Typography.Design` case (`default`, `rounded`, `serif`, `monospaced`; `standard` = `default`); styles largeTitle, title, title2, title3, headline, subheadline, body, callout, footnote, caption, caption2; weights regular, medium, semibold, bold

macOS type ramp (`fontSize` primitive, default weight regular unless noted; Q-11): largeTitle fontSize26 · title fontSize22 · title2 fontSize17 · title3 fontSize15 · headline fontSize13 bold · subheadline fontSize11 · body fontSize13 · callout fontSize12 · footnote fontSize10 · caption fontSize10 · caption2 fontSize10 medium. iOS and iPadOS: the system text styles (BR-6).

### Component tokens
- `DS.Theme.Components`: no configuration in this spec. Each later property aliases a semantic token or, for a size of the component alone, a `size` primitive (Q-10); a text-bound size joins the scaling list. `@MDS(\.{component})` (US-2) is verified by the first component spec with a configuration.

### Theme and amendment (DesignSystem, public)
- `DS.Theme`: `id: String`; `Equatable`, `Sendable`; `static let standard` (id `"standard"`); `func amended(by: Amendment) -> DS.Theme`.
- `DS.Theme.Amendment`: base theme id and overrides; `Sendable`; `static let sample`, base `standard`: Background.page → sand94 · sand15; Background.brand → pink38; Foreground.brand → pink38 · pink71; Typography.design → `serif`; Spacing.large → space48 (Q-7). Its color overrides keep their normal pair under Increase Contrast (BR-10).

### Access API (DesignSystem, public)
- `View.themeRoot(_:)` (scene root only), `View.theme(_:)`, `View.textSize(_:)`, `View.chromeTextSize()`, `View.contentTextSize()`
- `@MDS var mds`: `mds(color:)` → `Color`; `mds(spacing:)`, `mds(radius:)`, `mds(borderWidth:)` → `CGFloat`; `mds(font:)`, `mds(font:_:)` (weight, style) → `Font`; `mds(motion:)` → `Animation?`
- `@MDS(\.{component}) var configuration`
- `Color(mds:)` (key path from Colors, e.g. `\.background.infoSubtle`)
- Modifiers: `font(mds:)`, `font(mds:_:)`, `foregroundStyle(mds:)` (Foreground, or OnBackground as `\.onBackground.{token}`), `background(mds:)`, `background(mds:cornerRadius:)`, `border(mds:width:cornerRadius:)`, `clipShape(mds:)`, `tint(mds:)`, `padding(mds:)`, `padding(_:mds:)`, `animation(mds:value:)`

### Token inventory (`@_spi(Showcase)`, read-only)
- For a theme (amended or not): every primitive (name, scale, value; `accent` as system), every semantic token (group, name, alias: light and dark primitive with optional opacity and the Increase Contrast pair, or one primitive; Typography design as its case, macOS styles as their `fontSize` primitive), every component token (component, name, chain to a primitive). Order as in Data.

## Rules
- BR-1 Tiers: primitive values exist only in DesignKit, `package` access. A semantic value is an alias: a color a light and a dark color primitive, each optionally with an opacity primitive, plus an optional Increase Contrast pair of the same form; Spacing, Radius, BorderWidth and Motion one primitive of their scale (`space`, `radius`, `stroke`, `duration`); a macOS Typography style one `fontSize` primitive; Typography design a `Design` case, the one non-primitive token value; weights are the typed `Weight` default of each style or argument, not tokens (Q-11, Q-14). A component value aliases a semantic token or a `size` primitive (Q-10). A literal or a primitive of another scale in a theme or amendment, or a theme missing a token, fails to compile. Semantic and component definitions are DesignSystem types (`DS.Theme.SemanticTokens.*`, `DS.Theme.Components`), since colors resolve as SwiftUI shape styles.
- BR-2 Primitive and semantic names and values are exactly those of Data, which match the canvas Foundations pages; a change starts on the canvas.
- BR-3 Apps and Cores name tokens only by typed key path; semantic and component values are opaque, readable only through `mds` inside a view; no public API returns a primitive or the primitive behind a token (the SPI of BR-14 aside). An unknown or misplaced key path fails to compile (`.foregroundStyle(mds: \.page)` doesn't compile; `.background(mds: \.page)` does).
- BR-4 Port: the mechanics are FinanceTracker `Kits/DesignKit/Sources/DesignKitUI/Theme/`, `Tokens/` and `Support/DK.TextSize+Scale.swift`, public names and signatures kept, with these deviations only: `Palette` becomes DesignKit primitives (BR-1); macOS system colors become slate primitives (BR-2); `Border.success`, `Border.criticalSubtle` and the Increase Contrast pairs added; the macOS ramp as `fontSize` primitives and design as a `Design` case (BR-1); iOS typography and scaling (BR-6, BR-7); window background on macOS only (BR-9); the sample amendment as in Data (BR-10); `Components` empty; `sceneContentSize` not ported; SwiftLint formatting.
- BR-5 Colors resolve where they render: the theme from the environment, light or dark from that view's color scheme, the Increase Contrast pair when the system's Increase Contrast is on (a token without one uses its normal pair); `accent` from the system, which applies its own contrast (Q-4, Q-6).
- BR-6 Typography: every `mds` font uses the theme's design. macOS: the style's `fontSize` primitive × text size (percent / 100), the style's default weight. iOS and iPadOS: the system text style, scaled by Dynamic Type, its platform default weight; `DK.TextSize` has no effect (Q-2). A weight argument replaces the default weight. iOS and iPadOS ignore the `fontSize` primitives, so an amendment overriding a style's `fontSize` affects macOS only.
- BR-7 (verified by the first component spec with a text-bound size) Text-bound component sizes scale on macOS with text size and on iOS and iPadOS with Dynamic Type relative to body; spacing, radii, border widths, durations and other component sizes never scale.
- BR-8 macOS: `.textSize(_:)` sets the environment's text size and control size (85, 100 % regular; 115, 130, 150 % large; 175, 200 % extraLarge); `.chromeTextSize()` sets the system body font and regular control size; `.contentTextSize()` sets the `mds` body font and the control size of the text size. iOS and iPadOS: `.textSize(_:)` has no effect, `.chromeTextSize()` sets the system body font, `.contentTextSize()` the `mds` body font.
- BR-9 `.theme(_:)` injects the theme and sets the `mds` body font, tint Background.brand and the theme's font design; usable at any depth. `.themeRoot(_:)` at a scene root does the same and on macOS also sets Background.page as the window container background; iOS keeps system backgrounds (Q-3). A nested `.theme(_:)` never touches the window background (Q-12). A view without `.theme(_:)` renders `standard` (macOS at 100 %). Replacing the theme restyles views in place, keeping their state.
- BR-10 An amendment overrides a subset of one base theme's semantic or component tokens with other aliases (BR-1 applies); an overridden color without an Increase Contrast pair uses its new normal pair under Increase Contrast; `amended(by:)` with an amendment of another base returns the theme unchanged; on an amended theme it replaces the previous amendment, so at most one applies (both clauses verified by the first spec with a second theme or amendment, Q-13); the amended theme keeps its base id. `sample` covers the primitive and semantic tiers; the first component spec with a configuration adds a component override to it.
- BR-11 `mds(motion:)` and `animation(mds:value:)` give an ease-in-out animation of the token's duration; with Reduce Motion on, none.
- BR-12 `@MDS` reads theme, text size and Reduce Motion from the environment; a view using it updates when any changes.
- BR-13 DesignSystem imports no AppKit or UIKit; the platform differences of BR-6 to BR-9 live in DesignSystem.
- BR-14 The token inventory is `@_spi(Showcase)` in DesignSystem and derived from the themes themselves; only `DemoApps/` imports the SPI (Q-5).
- BR-15 Moved to foundations-pages BR-1 (Q-9).
- BR-16 Moved to foundations-pages BR-2 (Q-9).
- BR-17 The slice that adds the tiers updates `docs/architecture.md` (§3: DesignKit holds primitives only, DesignSystem the semantic and component definitions; §4: primitive scales add `size` and `fontSize`, the Component row says `size` primitives, Typography design the one non-primitive token value; §5: platform typography, `.themeRoot(_:)` at scene roots with the page background on macOS only; §9: removed, every item resolved by Q-2, Q-3, Q-6 and BR-1) and adds to `DesignKit/CLAUDE.md` the exception: the `@_spi(Showcase)` token inventory is the one catalog type in the package.
- BR-18 The rendered behavior of BR-5, BR-6, BR-8, BR-9, BR-11, BR-12 and the amendment override of BR-10, and the inventory of BR-14, are verified on the foundations-pages pages (its AC-2 to AC-12); BR-7 and the two BR-10 clauses noted there wait for the spec that can show them (Q-13); this spec's ACs cover compilation, the port and the scene roots.

## Copy
None: DesignSystem has no catalog copy yet; the showcase copy is foundations-pages.

## Acceptance criteria
- AC-1 Given the repo, when `scripts/gate.sh` runs, then every step passes.
- AC-2 Given a Swift file in `DemoApps/` that doesn't import the SPI, when it names a primitive (`blue43`) or reads a token's value outside `mds` (`mds(spacing: \.small)` returning a number outside a view), then it fails to compile; checked once in the slice that adds the tiers.
- AC-3 Given the `standard` theme, when a semantic token is set to a literal (`8`, a hex color) or to a primitive of another scale (`radius8` for Spacing, `space16` for a macOS Typography style), or a token is left out, then it fails to compile; checked once in the slice that adds the tiers. The same for a component token set to a literal or a `space` primitive is checked by the first component spec with a configuration (Q-13).
- AC-4 Given a view, when it uses `.foregroundStyle(mds: \.page)` or `.padding(mds: \DS.Theme.SemanticTokens.Radius.small)`, then it fails to compile; `.background(mds: \.page)` and `.padding(mds: \.small)` compile; checked once in the slice that adds the modifiers.
- AC-5 Given each ported file and its FinanceTracker source, when compared with `git diff --no-index -w`, then the only differences are the deviations of BR-4; checked once in the slice that ports it.
- AC-6 Given `Sources/DesignSystem`, when searched, then no file imports AppKit or UIKit; given the workspace, only `DemoApps/` files import `@_spi(Showcase)`.
- AC-7 to AC-14 Moved to foundations-pages AC-2 to AC-9 (Q-9).
- AC-15 Given ShowcaseMac, then the window background is FFFFFF in light and 1E1E1E in dark; given ShowcasePhone and ShowcasePad, the system backgrounds are unchanged; given the three apps' scene roots, when searched, then each window content carries `.themeRoot(.standard)` and `.chromeTextSize()`. (manual)
- AC-16 to AC-18 Moved to foundations-pages AC-10 to AC-12 (Q-9).

## Open questions
- None
