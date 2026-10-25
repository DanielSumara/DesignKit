@_spi(Showcase) import DesignSystem
import SwiftUI

internal struct SemanticTypographySection: View {
    private static let sample = "The quick brown fox jumps over the lazy dog"

    @MDS private var mds
    @Environment(PlaygroundEnvironment.self) private var playgroundEnvironment

    var body: some View {
        let inventory = playgroundEnvironment.resolvedTheme.inventory
        let entries = inventory.semanticTokens.filter { $0.kind == .typography }
        VStack(alignment: .leading, spacing: mds(spacing: \.medium)) {
            Text("Typography")
                .font(mds: \.title2)
            ForEach(entries, id: \.name) { entry in
                row(entry, in: inventory)
            }
            Text("Body weights")
                .font(mds: \.headline)
            ForEach(DS.Theme.Inventory.weightEntries, id: \.name) { weight in
                VStack(alignment: .leading, spacing: mds(spacing: \.xxSmall)) {
                    caption(weight.name)
                    Text(Self.sample)
                        .font(mds: weight.path, \.body)
                        .accessibilityLabel("Body \(weight.name)")
                }
            }
        }
    }

    @ViewBuilder
    private func row(_ entry: DS.Theme.Inventory.SemanticEntry, in inventory: DS.Theme.Inventory) -> some View {
        switch entry.path {
        case .typography(let path):
            VStack(alignment: .leading, spacing: mds(spacing: \.xxSmall)) {
                caption(label(of: entry, in: inventory))
                Text(Self.sample)
                    .font(mds: path)
                    .accessibilityLabel("Typography \(entry.name)")
            }
        case .design:
            VStack(alignment: .leading, spacing: mds(spacing: \.xxSmall)) {
                Text("Design")
                    .font(mds: \.headline)
                Text(SemanticPrimitiveText.text(of: entry, in: inventory))
                    .font(mds: \.body)
            }
        default:
            EmptyView()
        }
    }

    private func caption(_ text: String) -> some View {
        Text(text)
            .font(mds: \.caption)
            .foregroundStyle(mds: \.secondary)
    }

    private func label(of entry: DS.Theme.Inventory.SemanticEntry, in inventory: DS.Theme.Inventory) -> String {
        #if os(macOS)
        "\(entry.name) · \(SemanticPrimitiveText.text(of: entry, in: inventory))"
        #else
        entry.name
        #endif
    }
}
