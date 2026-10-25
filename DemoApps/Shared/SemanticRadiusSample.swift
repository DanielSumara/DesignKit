@_spi(Showcase) import DesignSystem
import SwiftUI

internal struct SemanticRadiusSample: View {
    @MDS private var mds
    let name: String
    let path: KeyPath<DS.Theme.SemanticTokens.Radius, DS.Theme.SemanticTokens.Radius.Value>

    var body: some View {
        Color.clear
            .frame(width: mds(spacing: \.xLarge), height: mds(spacing: \.xLarge))
            .background(mds: \.brand, cornerRadius: path)
            .accessibilityLabel("Radius \(name)")
    }
}
