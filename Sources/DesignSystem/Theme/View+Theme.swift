import SwiftUI

extension View {
    public func themeRoot(_ theme: DS.Theme) -> some View {
        #if os(macOS)
        self.theme(theme)
            .containerBackground(theme.semanticTokens.colors.background.page, for: .window)
        #else
        self.theme(theme)
        #endif
    }

    public func theme(_ theme: DS.Theme) -> some View {
        font(mds: \.body)
            .tint(theme.semanticTokens.colors.background.brand)
            .fontDesign(theme.semanticTokens.typography.design.fontDesign)
            .environment(\.theme, theme)
    }
}
