import SwiftUI

internal struct PageCollection<each Subject: Page> {
    let entries: [PageEntry]

    private let pages: (repeat each Subject)

    init(_ pages: repeat each Subject) {
        var entries: [PageEntry] = []
        for page in repeat each pages {
            entries.append(PageEntry(page))
        }
        self.entries = entries
        self.pages = (repeat each pages)
    }

    @MainActor
    func detail(selection: String) -> some View {
        TupleView((repeat PageDetailView(page: each pages, selection: selection)))
    }
}
