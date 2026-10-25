# Primitives in DesignSystem: decisions

- Q-1 What access do primitives get in DesignSystem? — `internal`: only DesignSystem reads them (themes, semantic tokens, inventory), and the SPI inventory maps them to its own types; platform targets reach tokens through `mds`. (BR-1)
- Q-2 How are the moved types named? — `DS.Theme.{Scale}Primitive` with protocol `DS.Theme.Primitive`, next to `DS.Theme.SemanticTokens`; files `Tokens/Primitives/DS.Theme+{Scale}Primitive.swift`. (BR-1)
- Q-3 When do the owner documents change? — With this spec, ahead of the code; the spec notes the lag. (Scope, BR-5)
- Q-4 Do the moved primitives stay under `no_literal_styling`? — Yes, no exclusion: the rule's regex finds no hit in the primitive files (hex is `.srgb(hex:)`, durations a `milliseconds:` label), so an exclusion would only loosen the rule; BR-6 and AC-6 removed in the revalidation. (Scope)
