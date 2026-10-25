extension DS.Theme {
    public struct Amendment: Sendable {
        let baseThemeID: String
        let apply: @Sendable (inout DS.Theme) -> Void
    }

    public func amended(by amendment: Amendment) -> DS.Theme {
        let unamended = base?.theme ?? self
        guard amendment.baseThemeID == unamended.id else { return self }
        var theme = unamended
        amendment.apply(&theme)
        theme.base = Base(unamended)
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
        theme.components.inlineAlert.radius = DS.Theme.Components.Radius(\.large)
    }
}
