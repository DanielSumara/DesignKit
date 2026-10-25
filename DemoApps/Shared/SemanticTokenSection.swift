@_spi(Showcase) import DesignSystem
import SwiftUI

internal struct SemanticTokenSection<Sample: View>: View {
    @MDS private var mds
    @Environment(PlaygroundEnvironment.self) private var playgroundEnvironment
    let title: String
    let kind: DS.Theme.Inventory.SemanticKind
    @ViewBuilder let sample: (DS.Theme.Inventory.SemanticEntry) -> Sample

    var body: some View {
        let inventory = playgroundEnvironment.resolvedTheme.inventory
        VStack(alignment: .leading, spacing: mds(spacing: \.medium)) {
            Text(title)
                .font(mds: \.title2)
            TokenRows(
                detailTitle: "Primitive",
                elements: inventory.semanticTokens.filter { $0.kind == kind },
                name: \.name,
                detail: { SemanticPrimitiveText.text(of: $0, in: inventory) },
                trailing: sample
            )
        }
    }
}
