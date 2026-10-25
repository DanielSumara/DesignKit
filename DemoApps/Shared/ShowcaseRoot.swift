import SwiftUI

internal struct ShowcaseRoot<each Platform: Page>: View {
    let catalog: Catalog<repeat each Platform>

    @State private var selection: String?
    @State private var playgroundEnvironment = PlaygroundEnvironment()

    var body: some View {
        NavigationSplitView {
            sidebar
        } detail: {
            detail
        }
        .environment(playgroundEnvironment)
    }

    private var sidebar: some View {
        List(selection: $selection) {
            ForEach(Section.allCases) { section in
                SwiftUI.Section(section.title) {
                    let pages = catalog.pages(in: section)
                    if pages.isEmpty {
                        Text("No pages yet")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(pages) { page in
                            NavigationLink(page.title, value: page.id)
                        }
                    }
                }
            }
        }
    }

    @ViewBuilder
    private var detail: some View {
        if let selection, catalog.contains(selection) {
            catalog.detail(selection: selection)
        } else {
            ContentUnavailableView {
                Text("Select a page")
            } description: {
                Text("Choose a page in the sidebar.")
            }
        }
    }
}

#Preview {
    ShowcaseRoot(catalog: Catalog())
}
