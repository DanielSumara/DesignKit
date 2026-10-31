import DesignKit
import SwiftUI

extension DS {
    public struct FieldRow<Value: Equatable, Control: View>: View {
        @MDS private var mds
        @MDS(\.fieldRow) private var configuration
        @Environment(\.horizontalSizeClass) private var horizontalSizeClass
        @Environment(\.formFocus) private var formFocus
        @FocusState private var localFocus: Bool
        @Environment(\.fieldID) private var fieldID
        @Environment(\.fieldLabelWidth) private var labelWidth
        @Binding private var field: DK.FormField<Value>
        private let control: (Binding<Value>) -> Control

        public init(_ field: Binding<DK.FormField<Value>>, @ViewBuilder control: @escaping (Binding<Value>) -> Control) {
            _field = field
            self.control = control
        }

        public var body: some View {
            register()
            return row
        }

        private var row: some View {
            layout {
                title
                column
            }
            .containerValue(\.isFieldRow, true)
            .onChange(of: field.supportText?.errorContent) { _, error in
                if let error, isFocused {
                    AccessibilityNotification.Announcement(announcement(error: error)).post()
                }
            }
        }

        private var layout: AnyLayout {
            if isCompact {
                AnyLayout(VStackLayout(alignment: .leading, spacing: mds(spacing: \.xxSmall)))
            } else {
                AnyLayout(FieldRowLayout(labelWidth: labelWidth, spacing: mds(spacing: \.medium)))
            }
        }

        private var isCompact: Bool {
            horizontalSizeClass == .compact
        }

        private var isFocused: Bool {
            if let formFocus, let fieldID {
                formFocus.isFocused(fieldID)
            } else {
                localFocus
            }
        }

        private var isLast: Bool? {
            guard let formFocus, let fieldID else { return nil }
            return formFocus.isLast(fieldID)
        }

        private var submitTriggers: SubmitTriggers {
            #if os(macOS)
            isLast == true ? [] : .text
            #else
            .text
            #endif
        }

        private func register() {
            guard let formFocus, let fieldID else { return }
            formFocus.registry.register(fieldID, handler: field.onFocusChange)
        }

        private func submit() {
            guard let formFocus, let fieldID else { return }
            formFocus.submit(from: fieldID)
        }

        private var title: some View {
            titleText
                .font(mds: \.body)
                .accessibilityHidden(true)
                .background {
                    GeometryReader { proxy in
                        Color.clear.preference(key: FieldLabelWidthKey.self, value: isCompact ? 0 : proxy.size.width)
                    }
                }
        }

        private var titleText: Text {
            let title = Text(verbatim: field.title).foregroundStyle(mds(color: \.foreground.primary))
            guard field.isOptional else { return title }
            let qualifier = Text("designSystem.fieldRow.optional", bundle: .module).foregroundStyle(mds(color: \.foreground.tertiary))
            return Text("\(title) \(qualifier)")
        }

        private var column: some View {
            VStack(alignment: .leading, spacing: configuration.supportSpacing.points) {
                focusable(control($field.value))
                    .submitLabel(isLast == false ? .next : .done)
                    .onSubmit(of: submitTriggers) { submit() }
                    .environment(\.fieldIsFocused, isFocused)
                    .environment(\.fieldShowsErrorState, field.supportText?.errorContent != nil)
                    .accessibilityLabel(accessibilityLabel)
                    .accessibilityHint(accessibilityHint)
                if let support = field.supportText, !support.content.isEmpty {
                    Text(verbatim: support.content)
                        .font(mds: \.footnote)
                        .foregroundStyle(configuration.supportTextColor.color(support))
                        .multilineTextAlignment(support.isFootnote ? .leading : .trailing)
                        .frame(maxWidth: .infinity, alignment: support.isFootnote ? .leading : .trailing)
                        .accessibilityHidden(true)
                }
            }
        }

        @ViewBuilder
        private func focusable(_ control: Control) -> some View {
            if let formFocus, let fieldID {
                control.focused(formFocus.focused, equals: fieldID)
            } else {
                control.focused($localFocus)
            }
        }

        private var accessibilityLabel: Text {
            let title = Text(verbatim: field.title)
            guard field.isOptional else { return title }
            return Text("\(title) \(Text("designSystem.fieldRow.optional", bundle: .module))")
        }

        private var accessibilityHint: String {
            field.supportText?.content ?? ""
        }

        private func announcement(error: String) -> String {
            String(format: String(localized: "designSystem.fieldRow.error", bundle: .module), field.title, error)
        }
    }
}

private struct FieldRowVariants: View {
    @MDS private var mds
    @State private var optional = DK.FormField(
        title: "Notes",
        value: "",
        isOptional: true,
        supportText: .error("Too long")
    )
    @State private var footnote = DK.FormField(title: "Name", value: "Groceries", supportText: .footnote("Shown in the list"))
    @State private var message = DK.FormField(title: "Amount", value: "10", supportText: .message("Applied to the next month"))

    var body: some View {
        VStack(spacing: mds(spacing: \.large)) {
            DS.FieldRow($footnote) { DS.FormTextField(text: $0, prompt: "Name") }
            DS.FieldRow($message) { DS.FormTextField(text: $0) }
            DS.FieldRow($optional) { DS.FormTextField(text: $0, prompt: "Notes") }
        }
        .padding(mds: \.large)
    }
}

#Preview("Light") {
    FieldRowVariants()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    FieldRowVariants()
        .preferredColorScheme(.dark)
}
