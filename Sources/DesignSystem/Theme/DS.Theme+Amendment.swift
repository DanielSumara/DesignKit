extension DS.Theme {
    public struct Amendment: Sendable {
        let baseThemeID: String
        let apply: @Sendable (inout DS.Theme) -> Void
    }

    public func amended(by amendment: Amendment) -> DS.Theme {
        guard amendment.baseThemeID == id else { return self }
        var theme = self
        amendment.apply(&theme)
        return theme
    }
}

extension DS.Theme.Amendment {
    public static let sample = DS.Theme.Amendment(baseThemeID: DS.Theme.standard.id) { theme in
        theme.semanticTokens.colors.background.page = DS.Theme.AdaptiveColor(light: .sand94, dark: .sand15)
        theme.semanticTokens.colors.background.brand = DS.Theme.AdaptiveColor(.pink38)
        theme.semanticTokens.colors.foreground.brand = DS.Theme.AdaptiveColor(light: .pink38, dark: .pink71)
        theme.semanticTokens.typography.design = .serif
        theme.semanticTokens.spacing.large = DS.Theme.SemanticTokens.Spacing.Value(.space48)
    }
}
