import DesignKit
@_spi(Showcase) import DesignSystem
import SwiftUI

@MainActor
internal struct FieldRowPage: Page {
    let id = "field-row"
    let title = "Field Row"
    let section = Section.molecules

    var content: some View {
        PageContent(title: title)
    }
}

private extension FieldRowPage {
    struct PageContent: View {
        let title: String
        @Environment(PlaygroundEnvironment.self) private var playgroundEnvironment

        var body: some View {
            ComponentPageView(
                title: title,
                properties: FormFieldProperties.all,
                tokens: playgroundEnvironment.componentTokens(of: "fieldRow"),
                playgroundIntro: "Playground: title, optional, support text kind and text, and the value, "
                    + "with the shared environment and the code.",
                variantsIntro: "Variants: no support text, footnote, message, error, optional and optional with an error, "
                    + "in light and dark.",
                configurationIntro: "Configuration: DK.FormField properties with their defaults, "
                    + "component tokens with their alias chains.",
                playground: { Playground() },
                variants: {
                    ComponentVariant(name: "No support text") {
                        Sample(isOptional: false, kind: .none)
                    }
                    ComponentVariant(name: "Footnote") {
                        Sample(isOptional: false, kind: .footnote)
                    }
                    ComponentVariant(name: "Message") {
                        Sample(isOptional: false, kind: .message)
                    }
                    ComponentVariant(name: "Error") {
                        Sample(isOptional: false, kind: .error)
                    }
                    ComponentVariant(name: "Optional") {
                        Sample(isOptional: true, kind: .none)
                    }
                    ComponentVariant(name: "Optional with error") {
                        Sample(isOptional: true, kind: .error)
                    }
                }
            )
        }
    }

    struct Sample: View {
        let isOptional: Bool
        let kind: SupportTextKind
        @State private var value = "Groceries"

        var body: some View {
            DS.FieldRow(field) { DS.FormTextField(text: $0, prompt: "Name") }
        }

        private var field: Binding<DK.FormField<String>> {
            Binding(
                get: {
                    DK.FormField(
                        title: "Title",
                        value: value,
                        isOptional: isOptional,
                        supportText: kind.supportText("Support text of the field")
                    )
                },
                set: { value = $0.value }
            )
        }
    }

    struct Playground: View {
        @State private var title = "Title"
        @State private var value = "Groceries"
        @State private var isOptional = false
        @State private var kind = SupportTextKind.footnote
        @State private var text = "Support text of the field"

        var body: some View {
            PlaygroundLayout(snippet: snippet) {
                DS.FieldRow(field) { DS.FormTextField(text: $0, prompt: "Name") }
            } controls: {
                TextField("Title", text: $title)
                TextField("Value", text: $value)
                Toggle("Optional", isOn: $isOptional)
                LabeledContent("Support text") {
                    Picker("Support text", selection: $kind) {
                        ForEach(SupportTextKind.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .labelsHidden()
                }
                TextField("Support text", text: $text)
            }
        }

        private var field: Binding<DK.FormField<String>> {
            Binding(
                get: {
                    DK.FormField(title: title, value: value, isOptional: isOptional, supportText: kind.supportText(text))
                },
                set: { value = $0.value }
            )
        }

        private var snippet: String {
            FormFieldSnippet.make(title: title, value: value, isOptional: isOptional, kind: kind, text: text)
                + "\nDS.FieldRow($field) { DS.FormTextField(text: $0, prompt: \"Name\") }"
        }
    }
}
