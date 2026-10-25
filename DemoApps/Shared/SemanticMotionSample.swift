@_spi(Showcase) import DesignSystem
import SwiftUI

internal struct SemanticMotionSample: View {
    @MDS private var mds
    @State private var played = false
    let name: String
    let path: KeyPath<DS.Theme.SemanticTokens.Motion, DS.Theme.SemanticTokens.Motion.Value>

    var body: some View {
        HStack(spacing: mds(spacing: \.medium)) {
            Button("Play") {
                played.toggle()
            }
            .buttonStyle(.bordered)
            .tint(mds: \.brand)
            .accessibilityLabel("Play \(name)")
            track
        }
    }

    private var track: some View {
        ZStack {
            Color.clear
                .frame(minWidth: mds(spacing: \.xxLarge), maxWidth: .infinity)
                .frame(height: mds(spacing: \.xSmall))
                .background(mds: \.neutral, cornerRadius: \.small)
            Color.clear
                .frame(width: mds(spacing: \.medium), height: mds(spacing: \.medium))
                .background(mds: \.brand, cornerRadius: \.large)
                .frame(maxWidth: .infinity, alignment: played ? .trailing : .leading)
        }
        .animation(mds: path, value: played)
        .accessibilityHidden(true)
    }
}
