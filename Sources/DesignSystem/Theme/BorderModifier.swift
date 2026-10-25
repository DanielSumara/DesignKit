import SwiftUI

internal struct BorderModifier: ViewModifier {
    @MDS private var mds
    let token: KeyPath<DS.Theme.SemanticTokens.Colors.Border, DS.Theme.AdaptiveColor> & Sendable
    let width: KeyPath<DS.Theme.SemanticTokens.BorderWidth, DS.Theme.SemanticTokens.BorderWidth.Value>
    let radius: KeyPath<DS.Theme.SemanticTokens.Radius, DS.Theme.SemanticTokens.Radius.Value>

    func body(content: Content) -> some View {
        content.overlay {
            RoundedRectangle(cornerRadius: mds(radius: radius), style: .continuous)
                .strokeBorder(DS.Theme.TokenColor(group: \.border, token: token), lineWidth: mds(borderWidth: width))
        }
    }
}
