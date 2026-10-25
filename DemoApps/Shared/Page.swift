import SwiftUI

internal struct Page: Identifiable {
    let id: String
    let title: String
    let section: Section
    let body: @MainActor () -> AnyView

    init<Content: View>(
        id: String,
        title: String,
        section: Section,
        @ViewBuilder body: @escaping @MainActor () -> Content
    ) {
        self.id = id
        self.title = title
        self.section = section
        self.body = { AnyView(body()) }
    }

    init(id: String, title: String, section: Section, component: ComponentPage) {
        self.id = id
        self.title = title
        self.section = section
        self.body = { AnyView(ComponentPageView(title: title, content: component)) }
    }
}
