@_spi(Showcase) import DesignSystem
import SwiftUI

internal struct SemanticMotionSample: View {
    private static let trackSteps: CGFloat = 5

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

    private var trackWidth: CGFloat {
        mds(spacing: \.xxLarge) * Self.trackSteps
    }

    private var track: some View {
        ZStack(alignment: .leading) {
            Color.clear
                .frame(width: trackWidth, height: mds(spacing: \.xSmall))
                .background(mds: \.neutral, cornerRadius: \.small)
            Color.clear
                .frame(width: mds(spacing: \.medium), height: mds(spacing: \.medium))
                .background(mds: \.brand, cornerRadius: \.large)
                .offset(x: played ? trackWidth - mds(spacing: \.medium) : 0)
        }
        .animation(mds: path, value: played)
        .accessibilityHidden(true)
    }
}
