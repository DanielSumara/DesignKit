@_spi(Showcase) import DesignSystem
import SwiftUI

internal struct SemanticTokenSection<Sample: View>: View {
    @MDS private var mds
    @Environment(PlaygroundEnvironment.self) private var playgroundEnvironment
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    let title: String
    let kind: DS.Theme.Inventory.SemanticKind
    @ViewBuilder let sample: (DS.Theme.Inventory.SemanticEntry) -> Sample

    var body: some View {
        let inventory = playgroundEnvironment.resolvedTheme.inventory
        let entries = inventory.semanticTokens.filter { $0.kind == kind }
        VStack(alignment: .leading, spacing: mds(spacing: \.medium)) {
            Text(title)
                .font(mds: \.title2)
            if horizontalSizeClass == .compact {
                stack(entries, in: inventory)
            } else {
                table(entries, in: inventory)
            }
        }
    }

    private func table(_ entries: [DS.Theme.Inventory.SemanticEntry], in inventory: DS.Theme.Inventory) -> some View {
        Grid(alignment: .leading, horizontalSpacing: mds(spacing: \.large), verticalSpacing: mds(spacing: \.small)) {
            GridRow {
                Text("Token")
                Text("Primitive")
            }
            .font(mds: \.caption)
            .foregroundStyle(mds: \.secondary)
            ForEach(entries, id: \.name) { entry in
                GridRow {
                    Text(entry.name)
                    Text(SemanticPrimitiveText.text(of: entry, in: inventory))
                        .foregroundStyle(mds: \.secondary)
                    sample(entry)
                }
                .font(mds: \.body)
            }
        }
    }

    private func stack(_ entries: [DS.Theme.Inventory.SemanticEntry], in inventory: DS.Theme.Inventory) -> some View {
        VStack(alignment: .leading, spacing: mds(spacing: \.medium)) {
            ForEach(entries, id: \.name) { entry in
                VStack(alignment: .leading, spacing: mds(spacing: \.xxSmall)) {
                    Text(entry.name)
                        .font(mds: \.body)
                    Text(SemanticPrimitiveText.text(of: entry, in: inventory))
                        .font(mds: \.caption)
                        .foregroundStyle(mds: \.secondary)
                    sample(entry)
                }
            }
        }
    }
}
