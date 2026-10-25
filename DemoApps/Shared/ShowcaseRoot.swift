import SwiftUI

internal struct ShowcaseRoot: View {
    let catalog: Catalog

    @State private var selection: Page.ID?
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
        if let selection, let page = catalog.page(withID: selection) {
            page.body().id(page.id)
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
    ShowcaseRoot(catalog: Catalog(platformPages: []))
}
