@MainActor
internal struct Catalog {
    static let sharedPages: [Page] = []

    let pages: [Page]

    init(platformPages: [Page]) {
        pages = Self.sharedPages + platformPages
    }

    func pages(in section: Section) -> [Page] {
        pages
            .filter { $0.section == section }
            .sorted { $0.title.localizedStandardCompare($1.title) == .orderedAscending }
    }

    func page(withID id: Page.ID) -> Page? {
        pages.first { $0.id == id }
    }
}
