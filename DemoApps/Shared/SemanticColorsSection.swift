@_spi(Showcase) import DesignSystem
import SwiftUI

internal struct SemanticColorsSection: View {
    @MDS private var mds
    @Environment(PlaygroundEnvironment.self) private var playgroundEnvironment

    var body: some View {
        VStack(alignment: .leading, spacing: mds(spacing: \.medium)) {
            Text("Colors")
                .font(mds: \.title2)
            ForEach(groups, id: \.name) { group in
                VStack(alignment: .leading, spacing: mds(spacing: \.small)) {
                    Text(group.name)
                        .font(mds: \.headline)
                    CompactSwitch {
                        SemanticColorStack(tokens: group.tokens)
                    } regular: {
                        SemanticColorTable(tokens: group.tokens)
                    }
                }
            }
        }
    }

    private var groups: [(name: String, tokens: [SemanticColorToken])] {
        SemanticColorToken.groups(of: playgroundEnvironment.resolvedTheme.inventory.semanticTokens)
    }
}
