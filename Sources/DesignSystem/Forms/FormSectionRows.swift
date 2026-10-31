import SwiftUI

internal struct FormSectionRows: View {
    let section: SectionConfiguration

    var body: some View {
        switch (section.header.isEmpty, section.footer.isEmpty) {
        case (false, false):
            Section {
                rows
            } header: {
                section.header
            } footer: {
                section.footer
            }
        case (false, true):
            Section {
                rows
            } header: {
                section.header
            }
        case (true, false):
            Section {
                rows
            } footer: {
                section.footer
            }
        case (true, true):
            Section {
                rows
            }
        }
    }

    private var rows: some View {
        ForEach(section.content) { subview in
            subview.environment(\.fieldID, FieldID(rawValue: subview.id))
        }
    }
}
