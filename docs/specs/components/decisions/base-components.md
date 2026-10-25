# Base components: decisions

- Q-1 Inline Alert padding was space12 on the canvas, but a component token aliases only a semantic token or a `size` primitive (theme-and-tokens BR-1) and no Spacing token is 12 pt. Answer: `inlineAlert.padding` aliases Spacing.medium (space16); the canvas is updated to match and stays Approved, with a changelog entry.
- Q-2 Edge Case image and monogram size, left open on the canvas. Answer: component token `edgeCase.iconSize` → size64, text-bound (scales); image corners Radius.large, monogram a circle.
- Q-3 What VoiceOver reads for the Inline Alert status icon. Answer: every status is labelled: Informacja / Information, Sukces / Success, Ostrzeżenie / Warning, Błąd / Error.
- Q-4 How the canvas follows `DK.Status` replacing `DK.InlineAlert.Style` (`Notice.style` → `Notice.status`). Answer: no typealias; the canvas Inline Alert snippet and Configuration are updated when the component is implemented.
- Q-5 Where `DK.Icon.image` data is decoded, DesignSystem importing only DesignKit and SwiftUI. Answer: ImageIO (`CGImageSource`) in DesignSystem; the Allowed imports rule and architecture §3 change in the same slice.
