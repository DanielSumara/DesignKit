# Package and showcase: decisions

- Q-1 What does the showcase navigate to before any component page exists? — A permanent Foundations page "Page anatomy", built on the page model, explaining each tab with a sample text subject. (BR-10)
- Q-2 Which playground controls ship before themes exist? — Appearance only; `foundations/theme-and-mds` adds Theme, Amendment and Text size, since it defines their effect. (BR-9)
- Q-3 How does the repo's gate run? — One script, `scripts/gate.sh`, logging to a file and stopping at the first failure. (BR-11, BR-12)
- Q-4 Should `DK.EdgeCase.symbol: String` become `DK.Icon`? — Yes: `icon: DK.Icon`, so edge cases can show symbols, images or monograms. (BR-3, Data)
- Q-5 Bundle identifier prefix of the showcase apps? — `com.sumara.designsystem.showcase`, suffixed `.phone`, `.pad`, `.mac`. (BR-5)
