import DesignKit
import SwiftUI

extension DS {
    public struct FieldRow<Value: Equatable, Control: View>: View {
        @MDS private var mds
        @MDS(\.fieldRow) private var configuration
        @Environment(\.horizontalSizeClass) private var horizontalSizeClass
        @State private var hasFocus = false
        @Binding private var field: DK.FormField<Value>
        private let control: (Binding<Value>) -> Control

        public init(_ field: Binding<DK.FormField<Value>>, @ViewBuilder control: @escaping (Binding<Value>) -> Control) {
            _field = field
            self.control = control
        }

        public var body: some View {
            Group {
                if horizontalSizeClass == .compact {
                    VStack(alignment: .leading, spacing: mds(spacing: \.xxSmall)) {
                        title
                        column
                    }
                } else {
                    LabeledContent {
                        column
                    } label: {
                        title
                    }
                }
            }
            .onPreferenceChange(FieldFocusPreferenceKey.self) { hasFocus = $0 }
            .onChange(of: field.supportText?.errorContent) { _, error in
                if let error, hasFocus {
                    AccessibilityNotification.Announcement(announcement(error: error)).post()
                }
            }
        }

        private var title: some View {
            titleText
                .font(mds: \.body)
                .accessibilityHidden(true)
        }

        private var titleText: Text {
            let title = Text(verbatim: field.title).foregroundStyle(mds(color: \.foreground.primary))
            guard field.isOptional else { return title }
            let qualifier = Text("designSystem.fieldRow.optional", bundle: .module).foregroundStyle(mds(color: \.foreground.tertiary))
            return Text("\(title) \(qualifier)")
        }

        private var column: some View {
            VStack(alignment: .leading, spacing: configuration.supportSpacing.points) {
                control($field.value)
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
