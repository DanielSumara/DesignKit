@_spi(Showcase) import DesignSystem
import SwiftUI

@MainActor
internal struct SemanticTokensPage: Page {
    let id = "semantic-tokens"
    let title = "Semantic tokens"
    let section = Section.foundations

    var content: some View {
        FoundationsPageShell(showsTextSize: true) {
            SectionsView()
        }
        .navigationTitle(title)
    }
}

private extension SemanticTokensPage {
    static let intro = "Each value aliases a primitive: colors as a light and dark pair with an optional "
        + "Increase Contrast pair, the rest one primitive."

    struct SectionsView: View {
        @MDS private var mds
        @Environment(PlaygroundEnvironment.self) private var playgroundEnvironment

        var body: some View {
            VStack(alignment: .leading, spacing: mds(spacing: \.large)) {
                Text(SemanticTokensPage.intro)
                    .font(mds: \.body)
                    .foregroundStyle(mds: \.secondary)
                colors
                SemanticTokenSection(title: "Spacing", kind: .spacing) { entry in
                    if case .spacing(let path) = entry.path {
                        SemanticSpacingSample(name: entry.name, path: path)
                    }
                }
                SemanticTokenSection(title: "Radius", kind: .radius) { entry in
                    if case .radius(let path) = entry.path {
                        SemanticRadiusSample(name: entry.name, path: path)
                    }
                }
                SemanticTokenSection(title: "Border width", kind: .borderWidth) { entry in
                    if case .borderWidth(let path) = entry.path {
                        SemanticBorderWidthSample(name: entry.name, path: path)
                    }
                }
                SemanticTokenSection(title: "Motion", kind: .motion) { entry in
                    if case .motion(let path) = entry.path {
                        SemanticMotionSample(name: entry.name, path: path)
                    }
                }
                SemanticTypographySection()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }

        private var colors: some View {
            VStack(alignment: .leading, spacing: mds(spacing: \.medium)) {
                Text("Colors")
                    .font(mds: \.title2)
                ForEach(colorGroups, id: \.name) { group in
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

        private var colorGroups: [(name: String, tokens: [SemanticColorToken])] {
            SemanticColorToken.groups(of: playgroundEnvironment.resolvedTheme.inventory.semanticTokens)
        }
    }

    struct SemanticTokenSection<Sample: View>: View {
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

    struct SemanticColorTable: View {
        @MDS private var mds
        let tokens: [SemanticColorToken]

        var body: some View {
            Grid(alignment: .leading, horizontalSpacing: mds(spacing: \.large), verticalSpacing: mds(spacing: \.small)) {
                GridRow {
                    Text("Token")
                    Text("Alias")
                    Text("Increase Contrast")
                    ForEach(SemanticColorSwatch.Kind.allCases, id: \.self) { kind in
                        Text(kind.title)
                    }
                }
                .font(mds: \.caption)
                .foregroundStyle(mds: \.secondary)
                ForEach(tokens) { token in
                    GridRow {
                        Text(token.name)
                        Text(token.aliasText)
                            .foregroundStyle(mds: \.secondary)
                        Text(token.increaseContrastText ?? "same")
                            .foregroundStyle(mds: \.secondary)
                        ForEach(SemanticColorSwatch.Kind.allCases, id: \.self) { kind in
                            SemanticColorSwatch(token: token, kind: kind)
                        }
                    }
                    .font(mds: \.body)
                }
            }
        }
    }

    struct SemanticColorStack: View {
        @MDS private var mds
        let tokens: [SemanticColorToken]

        var body: some View {
            VStack(alignment: .leading, spacing: mds(spacing: \.medium)) {
                ForEach(tokens) { token in
                    VStack(alignment: .leading, spacing: mds(spacing: \.xxSmall)) {
                        Text(token.name)
                            .font(mds: \.body)
                        Text(token.aliasText)
                            .font(mds: \.caption)
                            .foregroundStyle(mds: \.secondary)
                        Text("Increase Contrast: \(token.increaseContrastText ?? "same")")
                            .font(mds: \.caption)
                            .foregroundStyle(mds: \.secondary)
                        HStack(spacing: mds(spacing: \.small)) {
                            ForEach(SemanticColorSwatch.Kind.allCases, id: \.self) { kind in
                                SemanticColorSwatch(token: token, kind: kind)
                            }
                        }
                        Text(SemanticColorSwatch.Kind.allCases.map(\.title).joined(separator: " · "))
                            .font(mds: \.caption)
                            .foregroundStyle(mds: \.secondary)
                            .accessibilityHidden(true)
                    }
                }
            }
        }
    }

    struct SemanticColorSwatch: View {
        enum Kind: CaseIterable {
            case light
            case dark
            case lightIncreased
            case darkIncreased
            case current

            var title: String {
                switch self {
                case .light: "Light"
                case .dark: "Dark"
                case .lightIncreased: "Light increased"
                case .darkIncreased: "Dark increased"
                case .current: "Current"
                }
            }
        }

        let token: SemanticColorToken
        let kind: Kind

        var body: some View {
            SwatchSquare { fill }
                .accessibilityLabel("\(token.name) \(kind.title)")
        }

        @ViewBuilder
        private var fill: some View {
            switch kind {
            case .light: Color(mds: token.path).environment(\.colorScheme, .light)
            case .dark: Color(mds: token.path).environment(\.colorScheme, .dark)
            case .lightIncreased: Color(inventory: token.lightIncreased)
            case .darkIncreased: Color(inventory: token.darkIncreased)
            case .current: Color(mds: token.path)
            }
        }
    }

    struct SemanticColorToken: Identifiable {
        let name: String
        let path: KeyPath<DS.Theme.SemanticTokens.Colors, DS.Theme.AdaptiveColor> & Sendable
        let alias: DS.Theme.Inventory.ColorAlias

        var id: String { name }

        var aliasText: String {
            "\(Self.text(of: alias.light)) · \(Self.text(of: alias.dark))"
        }

        var increaseContrastText: String? {
            guard alias.increasedLight != nil || alias.increasedDark != nil else { return nil }
            return "\(Self.text(of: lightIncreased)) · \(Self.text(of: darkIncreased))"
        }

        var lightIncreased: DS.Theme.Inventory.ColorReference {
            alias.increasedLight ?? alias.light
        }

        var darkIncreased: DS.Theme.Inventory.ColorReference {
            alias.increasedDark ?? alias.dark
        }

        static func groups(of entries: [DS.Theme.Inventory.SemanticEntry]) -> [(name: String, tokens: [Self])] {
            entries.filter { $0.kind == .color }
                .orderedGroups(by: \.group)
                .map { group in
                    (group.key, group.elements.compactMap { entry in
                        guard case .color(let path) = entry.path, case .color(let alias) = entry.value else { return nil }
                        return Self(name: "\(entry.group).\(entry.name)", path: path, alias: alias)
                    })
                }
        }

        private static func text(of reference: DS.Theme.Inventory.ColorReference) -> String {
            guard let opacity = reference.opacity else { return reference.color }
            return "\(reference.color) @ \(opacity)"
        }
    }

    enum SemanticPrimitiveText {
        static func text(of entry: DS.Theme.Inventory.SemanticEntry, in inventory: DS.Theme.Inventory) -> String {
            switch entry.value {
            case .primitive(let scale, let name):
                guard let primitive = inventory.primitives.first(where: { $0.scale == scale && $0.name == name }) else {
                    return name
                }
                return "\(name) · \(PrimitiveValueText.text(of: primitive.value))"
            case .design(let design):
                return design
            case .color:
                return ""
            }
        }
    }

    struct SemanticTypographySection: View {
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

    struct SemanticMotionSample: View {
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

    struct SemanticBorderWidthSample: View {
        @MDS private var mds
        let name: String
        let path: KeyPath<DS.Theme.SemanticTokens.BorderWidth, DS.Theme.SemanticTokens.BorderWidth.Value>

        var body: some View {
            Color.clear
                .frame(width: mds(spacing: \.xLarge), height: mds(spacing: \.xLarge))
                .border(mds: \.strong, width: path, cornerRadius: \.small)
                .accessibilityLabel("Border width \(name)")
        }
    }

    struct SemanticRadiusSample: View {
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

    struct SemanticSpacingSample: View {
        @MDS private var mds
        let name: String
        let path: KeyPath<DS.Theme.SemanticTokens.Spacing, DS.Theme.SemanticTokens.Spacing.Value>

        var body: some View {
            Color.clear
                .frame(width: mds(spacing: path), height: mds(spacing: \.xSmall))
                .background(mds: \.brand)
                .accessibilityLabel("Spacing \(name)")
        }
    }
}
