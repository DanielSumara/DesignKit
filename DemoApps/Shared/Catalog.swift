import SwiftUI

internal struct Catalog<each Platform: Page> {
    private let shared = PageCollection(
        PageAnatomyPage(),
        ActionButtonPage(),
        ActivityIndicatorPage(),
        ComponentTokensPage(),
        PrimitivesPage(),
        SemanticTokensPage(),
        StatusIconPage(),
        InlineAlertPage()
    )
    private let platform: PageCollection<repeat each Platform>

    private var entries: [PageEntry] {
        shared.entries + platform.entries
    }

    init(platformPages: repeat each Platform) {
        platform = PageCollection(repeat each platformPages)
    }

    func pages(in section: Section) -> [PageEntry] {
        entries
            .filter { $0.section == section }
            .sorted { $0.title.localizedStandardCompare($1.title) == .orderedAscending }
    }

    func contains(_ id: String) -> Bool {
        entries.contains { $0.id == id }
    }

    @MainActor @ViewBuilder
    func detail(selection: String) -> some View {
        shared.detail(selection: selection)
        platform.detail(selection: selection)
    }
}
