@_spi(Showcase) import DesignSystem
import SwiftUI

internal struct SemanticBorderWidthSample: View {
    @MDS private var mds
    let name: String
    let path: KeyPath<DS.Theme.SemanticTokens.BorderWidth, DS.Theme.SemanticTokens.BorderWidth.Value>

    var body: some View {
        Color.clear
            .frame(width: mds(spacing: \.xLarge), height: mds(spacing: \.xLarge))
            .border(mds: \.strong, width: path, cornerRadius: \.small)
            .accessibilityLabel("Border width \(name)")
    }
}
