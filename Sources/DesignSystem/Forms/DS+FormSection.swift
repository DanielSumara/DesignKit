import DesignKit
import SwiftUI

extension DS {
    public struct FormSection<Content: View>: View {
        private let title: String?
        private let footer: String?
        private let content: Content

        public init(_ title: String?, footer: String? = nil, @ViewBuilder content: () -> Content) {
            self.title = title.flatMap { $0.isEmpty ? nil : $0 }
            self.footer = footer.flatMap { $0.isEmpty ? nil : $0 }
            self.content = content()
        }

        public var body: some View {
            switch (title, footer) {
            case (let title?, let footer?):
                Section {
                    content
                } header: {
                    Text(verbatim: title)
                } footer: {
                    footerText(footer)
                }
            case (let title?, nil):
                Section {
                    content
                } header: {
                    Text(verbatim: title)
                }
            case (nil, let footer?):
                Section {
                    content
                } footer: {
                    footerText(footer)
                }
            case (nil, nil):
                Section {
                    content
                }
            }
        }

        private func footerText(_ footer: String) -> some View {
            Text(verbatim: footer)
                .font(mds: \.footnote)
        }
    }
}

private struct FormSectionVariants: View {
    @State private var name = DK.FormField(title: "Name", value: "Groceries")
    @State private var notes = DK.FormField(title: "Notes", value: "", isOptional: true, supportText: .footnote("Shown in the list"))

    var body: some View {
        DS.Form {
            DS.FormSection("Details", footer: "Footer of the section") {
                DS.FieldRow($name) { DS.FormTextField(text: $0, prompt: "Name") }
                DS.FieldRow($notes) { DS.FormTextField(text: $0, prompt: "Notes") }
            }
            DS.FormSection(nil) {
                DS.FieldRow($name) { DS.FormTextField(text: $0) }
            }
        }
    }
}

#Preview("Light") {
    FormSectionVariants()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    FormSectionVariants()
        .preferredColorScheme(.dark)
}
