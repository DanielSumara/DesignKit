import SwiftUI

internal struct PaddingModifier: ViewModifier {
    @MDS private var mds
    let edges: Edge.Set
    let spacing: KeyPath<DS.Theme.SemanticTokens.Spacing, DS.Theme.SemanticTokens.Spacing.Value>

    func body(content: Content) -> some View {
        content.padding(edges, mds(spacing: spacing))
    }
}
