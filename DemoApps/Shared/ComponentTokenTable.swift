@_spi(Showcase) import DesignSystem
import SwiftUI

internal struct ComponentTokenTable: View {
    @MDS private var mds
    let name: String
    let entries: [DS.Theme.Inventory.ComponentEntry]

    var body: some View {
        VStack(alignment: .leading, spacing: mds(spacing: \.medium)) {
            Text(name)
                .font(mds: \.title2)
                .accessibilityAddTraits(.isHeader)
            TokenRows(detailTitle: "Alias chain", elements: entries, name: \.name, detail: \.aliasedName)
        }
    }
}
