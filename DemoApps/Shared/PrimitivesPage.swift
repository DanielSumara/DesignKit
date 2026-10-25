@_spi(Showcase) import DesignSystem
import SwiftUI

@MainActor
internal struct PrimitivesPage: Page {
    let id = "primitives"
    let title = "Primitives"
    let section = Section.foundations

    var content: some View {
        PrimitivesView()
            .navigationTitle(title)
    }
}

private extension PrimitivesPage {
    static let intro = "Raw values named {family}{step}; a color's step is its CIE L* lightness. "
        + "Only themes and amendments use them."

    struct PrimitivesView: View {
        @MDS private var mds
        private let primitives = DS.Theme.standard.inventory.primitives

        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: mds(spacing: \.large)) {
                    Text(PrimitivesPage.intro)
                        .font(mds: \.body)
                        .foregroundStyle(mds: \.secondary)
                    ForEach(colorFamilies, id: \.name) { family in
                        FamilyView(family: family)
                    }
                    ForEach(scales, id: \.name) { scale in
                        ScaleView(scale: scale)
                    }
                }
                .padding(mds: \.large)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }

        private var colorFamilies: [Family] {
            primitives.filter(\.isColor)
                .orderedGroups { String($0.name.prefix { $0.isLetter }) }
                .map { Family(name: $0.key, entries: $0.elements) }
        }

        private var scales: [Scale] {
            primitives.filter { !$0.isColor }
                .orderedGroups(by: \.scale)
                .map { Scale(name: $0.key, entries: $0.elements) }
        }
    }

    struct Family {
        let name: String
        var entries: [DS.Theme.Inventory.PrimitiveEntry]
    }

    struct Scale {
        let name: String
        var entries: [DS.Theme.Inventory.PrimitiveEntry]
    }

    struct FamilyView: View {
        @MDS private var mds
        let family: Family

        var body: some View {
            VStack(alignment: .leading, spacing: mds(spacing: \.small)) {
                Text(family.name)
                    .font(mds: \.headline)
                WrappingLayout(spacing: mds(spacing: \.medium)) {
                    ForEach(family.entries, id: \.name) { entry in
                        SwatchView(entry: entry)
                    }
                }
            }
        }
    }

    struct SwatchView: View {
        @MDS private var mds
        let entry: DS.Theme.Inventory.PrimitiveEntry

        var body: some View {
            VStack(alignment: .leading, spacing: mds(spacing: \.xxSmall)) {
                swatch
                Text(entry.name)
                    .font(mds: \.caption)
                Text(caption)
                    .font(mds: \.caption)
                    .foregroundStyle(mds: \.secondary)
            }
        }

        private var swatch: some View {
            SwatchSquare { Color(inventory: entry) }
        }

        private var caption: String {
            switch entry.value {
            case .srgb(let hex): String(format: "#%06X", hex)
            case .system: "System accent color"
            default: ""
            }
        }
    }

    struct ScaleView: View {
        @MDS private var mds
        let scale: Scale

        var body: some View {
            VStack(alignment: .leading, spacing: mds(spacing: \.small)) {
                Text("\(scale.name) (\(unit))")
                    .font(mds: \.headline)
                Grid(alignment: .leading, horizontalSpacing: mds(spacing: \.large), verticalSpacing: mds(spacing: \.xSmall)) {
                    ForEach(scale.entries, id: \.name) { entry in
                        GridRow {
                            Text(entry.name)
                            Text(PrimitiveValueText.text(of: entry.value))
                                .foregroundStyle(mds: \.secondary)
                        }
                        .font(mds: \.body)
                    }
                }
            }
        }

        private var unit: String {
            switch scale.entries.first?.value {
            case .milliseconds: "ms"
            case .percent: "%"
            default: "pt"
            }
        }
    }
}
