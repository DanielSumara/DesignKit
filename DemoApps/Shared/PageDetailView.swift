import SwiftUI

internal struct PageDetailView<Subject: Page>: View {
    let page: Subject
    let selection: String

    var body: some View {
        if page.id == selection {
            page.content.id(page.id)
        }
    }
}
