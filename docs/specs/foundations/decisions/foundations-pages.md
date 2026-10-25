# Foundations pages: decisions

- Q-1 Text size default on iOS and iPadOS? — System, first and default, applying no override so the device's Dynamic Type applies; an explicit size overrides it. (Playground environment, BR-3)
- Q-2 Where does the inventory's resolution (key paths for `mds`, `Color(inventory:)`) live? — In this spec: an additive `@_spi(Showcase)` extension in DesignSystem; theme-and-tokens stays closed, its inventory entries unchanged. (Scope, Data, BR-1, BR-9)
- Q-3 How does the Component tokens page show its Theme × Amendment? — With the Theme and Amendment controls at its top, sharing the session's values; no Text size. (Component tokens, BR-2, BR-6)
- Q-4 Order relative to primitives-in-design-system? — The primitive move lands first; this spec depends on it and names `DS.Theme.` primitive types. (Depends on, BR-9)
