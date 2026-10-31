import DesignKit
import SwiftUI

extension DS {
    public struct Form<Content: View>: View {
        @FocusState private var focused: FieldID?
        @State private var registrations: [FieldRegistration] = []
        @State private var focusedRegistration: FieldRegistration?
        private let content: Content

        public init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }

        public var body: some View {
            ScrollViewReader { proxy in
                SwiftUI.Form {
                    content
                }
                .formStyle(.grouped)
                .environment(\.formFocus, FormFocusContext(focused: $focused, order: registrations.map(\.id)))
                .onPreferenceChange(FieldRegistrationKey.self) { registrations = $0 }
                .onChange(of: registrations) { _, registrations in
                    if let focused, !registrations.contains(where: { $0.id == focused }) {
                        self.focused = nil
                    }
                }
                .onChange(of: focused) { old, new in
                    focusChanged(from: old, to: new)
                    if let new {
                        proxy.scrollTo(new)
                    }
                }
            }
        }

        private func focusChanged(from old: FieldID?, to new: FieldID?) {
            if old != nil {
                focusedRegistration?.onFocusChange(false)
                focusedRegistration = nil
            }
            if let new, let registration = registrations.first(where: { $0.id == new }) {
                focusedRegistration = registration
                registration.onFocusChange(true)
            }
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
