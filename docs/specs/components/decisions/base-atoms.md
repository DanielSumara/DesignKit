# Base atoms: decisions

- Q-6 base-components covered five components, a String Catalog, an import change and a color mapping, planning to about eight slices. Answer: split into base-atoms (Activity Indicator, Action Button, Status Icon) and base-molecules (Inline Alert, Edge Case), ids kept from base-components.
- Q-7 Which values a component draws become component tokens: every color and size, or only some. Themes and amendments are defined only inside DesignSystem, so no client overrides a token either way. Answer: a component token only for a value that varies by variant or belongs to the component alone; the rest read semantic tokens; tokens are added later as additive changes when a theme needs a component to differ (BR-16, architecture §4).
- Q-8 `DK.Status` overlaps the ported `DK.Tone` (neutral, info, success, warning, critical). Answer: keep `DK.Status`: severity is ordered and has no neutral; no conversion between the two.
