@_spi(Showcase) import DesignSystem
import SwiftUI

@MainActor
internal struct ComponentTokensPage: Page {
    let id = "component-tokens"
    let title = "Component tokens"
    let section = Section.foundations

    var content: some View {
        FoundationsPageShell(showsTextSize: false) {
            ComponentTokensContent()
        }
        .navigationTitle(title)
    }
}

private extension ComponentTokensPage {
    static let intro = [
        "One configuration per component, read only by that component through @MDS.",
        "Colors, radii, border widths and spacing alias semantic tokens; sizes of the component alone alias primitives.",
        "Text-bound sizes scale with the text size; spacing, radii, border widths and durations don't."
    ]

    struct ComponentTokensContent: View {
        @MDS private var mds
        @Environment(PlaygroundEnvironment.self) private var playgroundEnvironment

        var body: some View {
            VStack(alignment: .leading, spacing: mds(spacing: \.large)) {
                VStack(alignment: .leading, spacing: mds(spacing: \.xSmall)) {
                    ForEach(ComponentTokensPage.intro, id: \.self) { line in
                        Text(line)
                    }
                }
                .font(mds: \.body)
                .foregroundStyle(mds: \.secondary)
                if components.isEmpty {
                    Text("None")
                        .font(mds: \.body)
                        .foregroundStyle(mds: \.secondary)
                } else {
                    ForEach(components, id: \.key) { component in
                        ComponentTokenTable(name: component.key, entries: component.elements)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }

        private var components: [(key: String, elements: [DS.Theme.Inventory.ComponentEntry])] {
            playgroundEnvironment.resolvedTheme.inventory.componentTokens.orderedGroups(by: \.component)
        }
    }
}
