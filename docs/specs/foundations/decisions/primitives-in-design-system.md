# Primitives in DesignSystem: decisions

- Q-1 What access do primitives get in DesignSystem? — `internal`: only DesignSystem reads them (themes, semantic tokens, inventory), and the SPI inventory maps them to its own types; platform targets reach tokens through `mds`. (BR-1)
- Q-2 How are the moved types named? — `DS.Theme.{Scale}Primitive` with protocol `DS.Theme.Primitive`, next to `DS.Theme.SemanticTokens`; files `Tokens/Primitives/DS.Theme+{Scale}Primitive.swift`. (BR-1)
- Q-3 When do the owner documents change? — With this spec, ahead of the code; the spec notes the lag. (Scope, BR-5)
- Q-4 Do the moved primitives stay under `no_literal_styling`? — No: `Sources/DesignSystem/Tokens/Primitives/` is excluded, since primitives are the one place literal values live and the rule's `included` now covers them. (Scope, BR-6)
