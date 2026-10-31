import DesignKit
import SwiftUI

extension DS {
    public struct Form<Content: View>: View {
        private let content: Content

        public init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }

        public var body: some View {
            SwiftUI.Form {
                content
            }
            .formStyle(.grouped)
        }
    }
}

private struct FormVariants: View {
    @State private var name = DK.FormField(title: "Name", value: "Groceries", supportText: .footnote("Shown in the list"))
    @State private var amount = DK.FormField(title: "Amount", value: "10", supportText: .message("Applied to the next month"))
    @State private var notes = DK.FormField(title: "Notes", value: "", isOptional: true)
    @State private var category = DK.FormField(title: "Category", value: "Home", supportText: .error("Unknown category"))

    var body: some View {
        DS.Form {
            DS.FormSection("Details", footer: "Footer of the first section") {
                DS.FieldRow($name) { DS.FormTextField(text: $0, prompt: "Name") }
                DS.FieldRow($amount) { DS.FormTextField(text: $0) }
                DS.FieldRow($notes) { DS.FormTextField(text: $0, prompt: "Notes") }
            }
            DS.FormSection("Category") {
                DS.FieldRow($category) { DS.FormTextField(text: $0) }
            }
        }
    }
}

#Preview("Light") {
    FormVariants()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    FormVariants()
        .preferredColorScheme(.dark)
}
