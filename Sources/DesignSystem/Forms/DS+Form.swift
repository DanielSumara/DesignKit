import DesignKit
import SwiftUI

extension DS {
    public struct Form<Content: View>: View {
        @FocusState private var focused: FieldID?
        @State private var registry = FormFocusRegistry()
        @State private var labelWidth: CGFloat = 0
        private let content: Content

        public init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }

        public var body: some View {
            Group(sections: content) { sections in
                let order = fieldOrder(sections)
                ScrollViewReader { proxy in
                    SwiftUI.Form {
                        ForEach(sections) { section in
                            FormSectionRows(section: section)
                        }
                    }
                    .formStyle(.grouped)
                    .environment(\.formFocus, FormFocusContext(focused: $focused, order: order, registry: registry))
                    .environment(\.fieldLabelWidth, labelWidth)
                    .onPreferenceChange(FieldLabelWidthKey.self) { labelWidth = $0 }
                    .onChange(of: order) { _, order in
                        orderChanged(order)
                    }
                    .onChange(of: focused) { old, new in
                        focusChanged(from: old, to: new)
                        if let new {
                            proxy.scrollTo(new.rawValue)
                        }
                    }
                }
            }
        }

        private func fieldOrder(_ sections: SectionCollection) -> [FieldID] {
            sections.flatMap { section in
                section.content.filter(\.containerValues.isFieldRow).map { FieldID(rawValue: $0.id) }
            }
        }

        private func orderChanged(_ order: [FieldID]) {
            var keep = Set(order)
            if let focused {
                keep.insert(focused)
            }
            registry.prune(keeping: keep)
            if let focused, !order.contains(focused) {
                self.focused = nil
            }
        }

        private func focusChanged(from old: FieldID?, to new: FieldID?) {
            if let old {
                registry.notify(old, focused: false)
            }
            if let new {
                registry.notify(new, focused: true)
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
