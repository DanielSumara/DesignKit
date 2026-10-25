# DesignKit repo

Public Swift package: the design system of the HomeBudget apps. Workspace rules: `../CLAUDE.md`; structure and reasons: `docs/architecture.md`; recipes and the Design System canvas: skill `design-system`.

## Rules
- Targets: `DesignKit` (Foundation; `DK` data, no tokens), `DesignSystem` (SwiftUI; `DS`, `mds`, every token tier: `internal` primitives, semantic and component definitions), `MacDesignSystem` (AppKit), `PadDesignSystem` and `PhoneDesignSystem` (UIKit); platform targets extend `DS` and exist only once they hold code
- Token tiers: primitive → semantic → component; each tier aliases only the one below; primitives only in themes and amendments; a component token only for a value varying by variant or the component's own, the rest semantic; no public token values, semantic and component values are opaque
- Components: one per file `DS+{Component}.swift`, one `DK` data object each, atomic levels composing only lower levels, native controls wrapped, light and dark previews; no gallery or catalog types in the package, except the `@_spi(Showcase)` token inventory, the one catalog type
- A component is built only from an `Approved` spec in `docs/specs/components/`, after its canvas page is `Approved`; the same task adds its showcase page
- Copy: String Catalog `designSystem.{component}.{element}`, pl and en; canvas and showcase copy in English
- Public API is the product: additive changes are minor versions, breaking changes major (SemVer tags; `CHANGELOG.md` per release)

## Commands
- Gate: `scripts/gate.sh [logfile]`: tool check, lint, package build, iOS build, xcodegen, three Showcase builds; stops at the first failure; log in `$TMPDIR` by default
- Lint: `swiftlint lint --strict --quiet`
- Build: `xcrun swift build --build-system swiftbuild -Xswiftc -warnings-as-errors`; iOS: `xcodebuild -scheme DesignSystem -destination 'generic/platform=iOS' build SWIFT_TREAT_WARNINGS_AS_ERRORS=YES`
- Showcase: `cd DemoApps && xcodegen generate`, then build `ShowcaseMac` (`platform=macOS`), `ShowcasePhone` and `ShowcasePad` (`generic/platform=iOS Simulator`; no development team), each with `SWIFT_TREAT_WARNINGS_AS_ERRORS=YES`
