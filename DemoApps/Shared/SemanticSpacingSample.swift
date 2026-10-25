@_spi(Showcase) import DesignSystem
import SwiftUI

internal struct SemanticSpacingSample: View {
    @MDS private var mds
    let name: String
    let path: KeyPath<DS.Theme.SemanticTokens.Spacing, DS.Theme.SemanticTokens.Spacing.Value>

    var body: some View {
        Color.clear
            .frame(width: mds(spacing: path), height: mds(spacing: \.xSmall))
            .background(mds: \.brand)
            .accessibilityLabel("Spacing \(name)")
    }
}
