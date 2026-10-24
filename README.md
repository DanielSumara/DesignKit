# DesignKit

A themable SwiftUI design system for iOS, iPadOS and macOS apps, built on Apple's native controls. Atomic components, three tiers of design tokens, runtime theme amendments and text scaling.

> Status: foundations in progress. The first components are specified in `docs/specs/` and shown in the showcase apps.

## Approach

- **Data in, views out.** Screens never style themselves. Their logic layer builds display-ready data objects (`DK.*`: platform-independent, Foundation only), and SwiftUI components (`DS.*`) render them.
- **Tokens only, never literals.** Components and screens reach colors, fonts, spacing, radii, border widths and durations through the compiler-checked `mds` APIs:
  - `.padding(mds: \.medium)`, `.foregroundStyle(mds: \.secondary)`, `Color(mds: \.background.infoSubtle)`, `@MDS var mds`
  - An unknown token, a token from the wrong group, or a literal fails to build.
- **Native first.** Components wrap SwiftUI controls and keep system chrome (Liquid Glass, sidebars, toolbars), so each platform follows its Human Interface Guidelines. The theme drives content and tint.
- **Accessible by default:**
  - light and dark appearance
  - Increase Contrast
  - Reduce Motion (`mds` animations turn off)
  - VoiceOver labels
  - text scaling

## Multi-platform packages

| Product | Platforms | Imports | Holds |
|---|---|---|---|
| `DesignKit` | all | Foundation | `DK` data objects; token values (package-internal) |
| `DesignSystem` | all | DesignKit, SwiftUI | `DS` components, theme, `mds` APIs, scene setup |
| `MacDesignSystem` | macOS | DesignSystem, AppKit | macOS-only components and AppKit wrappers |
| `PadDesignSystem` | iPadOS | DesignSystem, UIKit | iPad-only components and UIKit wrappers |
| `PhoneDesignSystem` | iOS | DesignSystem, UIKit | iPhone-only components and UIKit wrappers |

Shared code comes first. A platform target exists only for what really differs. Everything extends the same `DS` namespace, so a screen uses the same names on every platform. Platforms: iOS 26, iPadOS 26, macOS 26; Swift 6.

## Atomic design

Components are organised as **Atoms → Molecules → Organisms → Templates**. Each level composes only lower ones, and Pages are the app's own screens.

One component lives in one file, `DS+{Component}.swift`. It renders one `DK` data object and is shown in light and dark previews.

## Design tokens: primitive → semantic → component

DesignKit follows [Figma's design-token architecture](https://www.figma.com/resource-library/design-token-architecture/):

| Tier | Purpose | Example |
|---|---|---|
| **Primitive** | Raw values without meaning: color ramps named by family and lightness, plus spacing, radius, border-width, duration and opacity scales | `blue43`, `blue96`, `space8` |
| **Semantic** | Values named by purpose, each an alias of a primitive (colors as light/dark pairs) | `Background.infoSubtle → blue96 / blue17`, `Spacing.medium → space16` |
| **Component** | One component's configuration, aliasing semantic tokens or, for sizes, primitives | `InlineAlert.iconSize → 16`, `InlineAlert.background(info) → Background.infoSubtle` |

- Only themes see primitives.
- Components read semantic and component tokens.
- Screens read semantic tokens only.
- Changing one primitive restyles everything that aliases it. Changing one semantic token restyles every component that uses it.

## Themes, configuration and amendments

- **Theme:** a complete mapping of semantic and component tokens. A missing value is a build error. `DS.Theme.standard` is built in.
- **Configuration:** each component's sizes, spacing and durations are part of the theme (`@MDS(\.inlineAlert)`), never generic size tokens.
- **Amendment:** overrides any subset of semantic or component tokens on top of a base theme, for example a different brand ramp or roomier spacing. It is applied at runtime with `theme.amended(by:)`, and views restyle in place without relaunching. At most one amendment is active at a time.
- **Scene setup:** `.theme(_:)` at every scene root injects the theme, tint, font design and page background.

## Scaling

`DK.TextSize` has seven steps, from 85 % to 200 %, set with `.textSize(_:)`.
- These scale with it:
  - `mds` fonts
  - text-bound component sizes, such as an icon beside a title
  - control sizes
- These stay fixed:
  - spacing
  - radii
  - border widths
  - durations
- System chrome keeps the system size.

## Showcase apps

`DemoApps/` holds three showcase apps: **ShowcasePhone**, **ShowcasePad** and **ShowcaseMac**. Each is a split view:
- The sidebar lists the foundations (primitives, semantic tokens) and the components by atomic level.
- Each component page has three parts:
  - **Playground:** live controls for every configuration property, theme, amendment, appearance and text size, with the matching `DK` snippet
  - **Variants:** every variant in light and dark
  - **Configuration:** properties and their token aliases

```bash
cd DemoApps && xcodegen generate && open Showcase.xcodeproj
```

## Using it

```swift
.package(url: "https://github.com/DanielSumara/DesignKit.git", from: "0.1.0")
```

Depend on `DesignKit` in platform-independent code. Depend on `DesignSystem`, plus the platform product you need, in UI code.

## Development

- Spec-driven: `docs/specs/`, `docs/plans/`. Architecture: `docs/architecture.md`.
- Quality gate: `swiftlint lint --strict`.
- Tests: none for views. The showcase apps are the verification surface.

## License

See [LICENSE](LICENSE).
