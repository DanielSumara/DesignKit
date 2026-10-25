internal struct PageEntry: Identifiable {
    let id: String
    let title: String
    let section: Section

    init(_ page: some Page) {
        id = page.id
        title = page.title
        section = page.section
    }
}
