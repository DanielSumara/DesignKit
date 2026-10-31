import SwiftUI

internal struct FormSectionRows: View {
    let section: SectionConfiguration

    var body: some View {
        FormSectionContainer(
            header: section.header.isEmpty ? nil : section.header,
            footer: section.footer.isEmpty ? nil : section.footer
        ) {
            rows
        }
    }

    private var rows: some View {
        ForEach(section.content) { subview in
            subview.environment(\.fieldID, FieldID(rawValue: subview.id))
        }
    }
}
