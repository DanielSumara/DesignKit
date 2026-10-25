import SwiftUI

internal struct ClipShapeModifier: ViewModifier {
    @MDS private var mds
    let radius: KeyPath<DS.Theme.SemanticTokens.Radius, DS.Theme.SemanticTokens.Radius.Value>

    func body(content: Content) -> some View {
        content.clipShape(RoundedRectangle(cornerRadius: mds(radius: radius), style: .continuous))
    }
}
