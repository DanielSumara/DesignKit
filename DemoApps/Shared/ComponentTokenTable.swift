@_spi(Showcase) import DesignSystem
import SwiftUI

internal struct ComponentTokenTable: View {
    @MDS private var mds
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    let name: String
    let entries: [DS.Theme.Inventory.ComponentEntry]

    var body: some View {
        VStack(alignment: .leading, spacing: mds(spacing: \.medium)) {
            Text(name)
                .font(mds: \.title2)
                .accessibilityAddTraits(.isHeader)
            if horizontalSizeClass == .compact {
                stack
            } else {
                table
            }
        }
    }

    private var table: some View {
        Grid(alignment: .leading, horizontalSpacing: mds(spacing: \.large), verticalSpacing: mds(spacing: \.small)) {
            GridRow {
                Text("Token")
                Text("Alias chain")
            }
            .font(mds: \.caption)
            .foregroundStyle(mds: \.secondary)
            ForEach(entries, id: \.name) { entry in
                GridRow {
                    Text(entry.name)
                    Text(entry.aliasedName)
                        .foregroundStyle(mds: \.secondary)
                }
                .font(mds: \.body)
            }
        }
    }

    private var stack: some View {
        VStack(alignment: .leading, spacing: mds(spacing: \.medium)) {
            ForEach(entries, id: \.name) { entry in
                VStack(alignment: .leading, spacing: mds(spacing: \.xxSmall)) {
                    Text(entry.name)
                        .font(mds: \.body)
                    Text(entry.aliasedName)
                        .font(mds: \.caption)
                        .foregroundStyle(mds: \.secondary)
                }
                .accessibilityElement(children: .combine)
            }
        }
    }
}
