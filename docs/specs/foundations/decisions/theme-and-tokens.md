# Theme and tokens: decisions

- Q-1 One spec or two (index rows `tokens` and `theme-and-mds`)? — One spec, `theme-and-tokens`, covering the tiers, theme, text size, `mds` APIs and the showcase Foundations pages. (Goal, Scope)
- Q-2 Type ramp and text size on iPhone and iPad? — iOS and iPadOS use the system text styles following Dynamic Type; `DK.TextSize` scales only on macOS, over the fixed macOS ramp. (BR-6, BR-7, BR-8)
- Q-3 Where does `.theme(_:)` apply Background.page? — As the macOS window container background only; iOS keeps system backgrounds. (BR-9)
- Q-4 Brand color? — The system accent color, as on the canvas: the user's accent on macOS, the app's AccentColor (system blue without one) on iOS. (Data, BR-5)
- Q-5 How do the showcase Foundations pages read primitive values and alias chains? — A read-only `@_spi(Showcase)` token inventory derived from the themes; only `DemoApps/` imports it; `DesignKit/CLAUDE.md` gets a one-line exception. (BR-14, BR-15, BR-17)
- Q-6 How do colors handle Increase Contrast? — In this spec: every color token has an Increase Contrast pair from existing primitives (canvas Foundations page first); fills behind white text darken, behind dark text lighten, text on subtle fills goes to the ramp ends, borders drop their opacity; "same" keeps the normal pair. (Data, BR-1, BR-5, BR-10)
- Q-7 Sample amendment Spacing.large without a 64 pt primitive? — space48; no primitive just for the sample. (Data)
- Q-8 When are `size48` and `size64` added? — With the Activity Indicator and Edge Case specs, after their canvas pages are approved; this spec keeps the canvas size scale. (Data)
- Q-9 Split the showcase work out? — Yes: the Foundations pages and the playground Theme, Amendment and Text size controls move to `foundations/foundations-pages`, which verifies this spec's rendered behavior; this spec keeps the tiers, theme, amendment, text size, `mds` APIs and the inventory. (Goal, Scope, BR-18)
- Q-10 Which primitives may a component token alias directly? — `size` only; spacing and motion go through semantic tokens. (BR-1, Data)
- Q-11 How does typography fit the tiers? — The macOS ramp is a DesignKit primitive scale `fontSize10…fontSize26`, each macOS style aliasing one; `design` is a typed `Design` case, the one non-primitive value. The canvas Foundations page adds the scale first (BR-2). (Data, BR-1, BR-6)
