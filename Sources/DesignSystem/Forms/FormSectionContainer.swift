import SwiftUI

internal struct FormSectionContainer<Rows: View, Header: View, Footer: View>: View {
    private let header: Header?
    private let footer: Footer?
    private let rows: Rows

    init(header: Header?, footer: Footer?, @ViewBuilder rows: () -> Rows) {
        self.header = header
        self.footer = footer
        self.rows = rows()
    }

    var body: some View {
        switch (header, footer) {
        case (let header?, let footer?):
            Section {
                rows
            } header: {
                header
            } footer: {
                footer
            }
        case (let header?, nil):
            Section {
                rows
            } header: {
                header
            }
        case (nil, let footer?):
            Section {
                rows
            } footer: {
                footer
            }
        case (nil, nil):
            Section {
                rows
            }
        }
    }
}
