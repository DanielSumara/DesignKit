# DesignKit lint and showcase pitfalls
Check: Before writing DemoApps pages or lint config for a new repo.

- `Package.swift` must be in `.swiftlint.yml` `excluded`: the custom `no_comments` rule rejects the mandatory `// swift-tools-version` line and `explicit_top_level_acl` rejects `let package`.
- `explicit_top_level_acl` and `one_declaration_per_file` apply to `DemoApps/` too: every top-level type needs `internal`; a stateful page is one `View` struct holding `static var page`, not two types.
- The showcase's own `Section` enum hides SwiftUI's `Section`; write `SwiftUI.Section`.
- App targets are not main-actor by default: shared static state needs `@MainActor` (`Catalog`, `PageAnatomyPage`).
- ShowcasePad single scene: `INFOPLIST_KEY_UIApplicationSupportsMultipleScenes` is ignored; project.yml writes `DemoApps/Generated/ShowcasePad-Info.plist` (gitignored) instead.
- Segmented `Picker` hides its title on iOS; wrap in `LabeledContent` with `.labelsHidden()`.
- `file_name` lint: an extension of `DS.Theme` or deeper must be named `DS.Theme+X.swift` (not `DS+Theme+X.swift`); AC-5 port diffs map names by hand.
- `one_declaration_per_file` counts private modifier structs in extension files: each further one needs its own file as `internal struct`. `private` members are visible only to extensions of the same type, not of another type in the same file.
- `cyclomatic_complexity` rejects a switch over the 11 text styles: use a static key-path dictionary.
- App files using `themeRoot`/`chromeTextSize` need `import DesignSystem`, not only `SwiftUI`.
- `scripts/gate.sh` resolves a relative log argument to absolute before any `cd`.
- `no_literal_styling` flags `.seconds(3)` even in previews and static lets: store `Int` seconds in a static let and call `.seconds(seconds)`; bare literals like a `/ 100` divisor go in a static too.
- In a page's private extension a typealias named `State` clashes with `@State`; `@Entry var x: T?` must not have `= nil` (`implicit_optional_initialization`); `sorted_imports` wants `import DesignKit` before `@_spi(Showcase) import DesignSystem`.
- `ComponentVariant` renders light and dark copies: keyed buttons (`.defaultAction`/`.cancelAction`) in Variants collide with a keyboard demo; put it where no other keyed button is visible (Playground).
- `DK.TextSize.scale` is 1 on iOS; text-bound component sizes scale there through `MDS`'s `@ScaledMetric(relativeTo: .body)` body factor, not in the view.
- Never pass a token `ShapeStyle` to `.tint` directly: tokens aliasing the `.accent` primitive resolve via `Color.accentColor`, which reads the tint, so it recurses to a stack overflow on macOS. Use `tint(mds:)` / `resolvedTint`, which resolve the colour in the outer environment first.
- To reproduce a showcase crash headless: temporarily default `ShowcaseRoot.selection` and `ComponentPageView.tab`, build with `-derivedDataPath` in the scratchpad, run the binary, read the new `~/Library/Logs/DiagnosticReports/ShowcaseMac-*.ips`; revert the edits.
- A new Spacing, Radius or BorderWidth component token has points only through `resolved(against:)` (run by `DS.Theme.Reader.components`); reading the theme directly gives 0. DS copy from the String Catalog needs `bundle: .module`.
- Component views: `scaledToFill` before the iconSize frame lets the clip use the oversized rect (frame first, then `clipShape`); wide text in a monogram circle must be laid out in the inscribed square (iconSize/√2), not the full square. Token files import Foundation, not CoreGraphics (Allowed imports).
- Showcase image assets: a plain PNG in `DemoApps/Shared/Resources` read via `Bundle.main` (xcodegen bundles it, Shared must avoid UIKit/AppKit so no `NSDataAsset`). DemoApps cannot reach `internal` DesignSystem helpers.
- macOS BSD `sed -i` needs `-i ''`; never end a chained shell command with a stray `cat` (it waits on stdin and hangs).
