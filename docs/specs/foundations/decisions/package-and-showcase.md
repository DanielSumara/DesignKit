# Package and showcase: decisions

- Q-1 What does the showcase navigate to before any component page exists? — A permanent Foundations page "Page anatomy", built on the page model, explaining each tab with a sample text subject. (BR-10)
- Q-2 Which playground controls ship before themes exist? — Appearance only; `foundations/theme-and-mds` adds Theme, Amendment and Text size, since it defines their effect. (BR-9)
- Q-3 How does the repo's gate run? — One script, `scripts/gate.sh`, logging to a file and stopping at the first failure. (BR-11, BR-12)
- Q-4 Should `DK.EdgeCase.symbol: String` become `DK.Icon`? — Yes: `icon: DK.Icon`, so edge cases can show symbols, images or monograms. (BR-3, Data)
- Q-5 Bundle identifier prefix of the showcase apps? — `com.sumara.designsystem.showcase`, suffixed `.phone`, `.pad`, `.mac`. (BR-5)
- Q-6 How is BR-7 (no literal styling in the showcase) enforced? — This spec widens `no_literal_styling` to `DemoApps/` Swift files, so lint checks it from the start and `foundations/theme-and-mds` owes nothing. (BR-7, AC-3)
- Q-7 Are the internal helpers `Locale+Localized` and `WrappingLayout` ported now? — No: they and DesignSystem's String Catalog move to the first spec that uses them; only the public fundamentals are ported. (Scope, BR-1, BR-2 removed, BR-3)
- Q-8 How do the iOS showcase apps build without a development team? — For `generic/platform=iOS Simulator`; device builds need a team. ShowcaseMac stays signed to run locally. (BR-5, BR-11, AC-4)
- Q-9 How is the port checked against FinanceTracker? — By an exact file list (AC-5) and a once-per-port `git diff --no-index -w` against each source (AC-17), not by comparing APIs by hand. (BR-3)
- Q-10 Do Swift warnings fail the gate? — Yes: `-warnings-as-errors` for `swift build`, `SWIFT_TREAT_WARNINGS_AS_ERRORS=YES` for `xcodebuild`. (BR-11, AC-1, AC-2, AC-4, AC-7)
- Q-11 Does `implement-increment` use the gate script? — Yes: in a repo with `scripts/gate.sh`, it is the gate. (BR-11, US-4)
- Q-12 How does the first slice pass `implement-increment`'s baseline with no sources yet? — A repo with no Swift sources has a clean `git status` as its baseline, recorded `Baseline: empty` in the plan (`implement-increment` §2). (BR-11)
