import SwiftUI

internal struct RoundedBackgroundModifier: ViewModifier {
    @MDS private var mds
    let token: KeyPath<DS.Theme.SemanticTokens.Colors.Background, DS.Theme.AdaptiveColor> & Sendable
    let radius: KeyPath<DS.Theme.SemanticTokens.Radius, DS.Theme.SemanticTokens.Radius.Value>

    func body(content: Content) -> some View {
        content.background(
            DS.Theme.TokenColor(group: \.background, token: token),
            in: RoundedRectangle(cornerRadius: mds(radius: radius), style: .continuous)
        )
    }
}
