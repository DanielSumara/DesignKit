import DesignKit
@_spi(Showcase) import DesignSystem
import SwiftUI

@MainActor
internal struct FormTextFieldPage: Page {
    let id = "form-text-field"
    let title = "Form Text Field"
    let section = Section.atoms

    var content: some View {
        PageContent(title: title)
    }
}

private extension FormTextFieldPage {
    static let properties = [
        ComponentProperty(name: "text", type: "Binding<String>", defaultValue: "none, required"),
        ComponentProperty(name: "prompt", type: "String?", defaultValue: "nil"),
        ComponentProperty(name: "error", type: "set by the enclosing DS.FieldRow", defaultValue: "support text .error")
    ]

    struct PageContent: View {
        let title: String
        @Environment(PlaygroundEnvironment.self) private var playgroundEnvironment

        var body: some View {
            ComponentPageView(
                title: title,
                properties: FormTextFieldPage.properties,
                tokens: playgroundEnvironment.componentTokens(of: "fieldRow"),
                playgroundIntro: "Playground: prompt, text and the error state, with the shared environment and the code. "
                    + "The error state comes from the enclosing Field Row, so it is shown inside one.",
                variantsIntro: "Variants: empty with a prompt, with text, and with an error, in light and dark.",
                configurationIntro: "Configuration: properties with their defaults, "
                    + "component tokens with their alias chains.",
                playground: { Playground() },
                variants: {
                    ComponentVariant(name: "Empty with prompt") {
                        Sample(text: "", prompt: "Name", isError: false)
                    }
                    ComponentVariant(name: "With text") {
                        Sample(text: "Groceries", prompt: "Name", isError: false)
                    }
                    ComponentVariant(name: "Error") {
                        Sample(text: "Groceries", prompt: "Name", isError: true)
                    }
                }
            )
        }
    }

    struct Sample: View {
        let prompt: String
        let isError: Bool
        @State private var text: String

        init(text: String, prompt: String, isError: Bool) {
            _text = State(initialValue: text)
            self.prompt = prompt
            self.isError = isError
        }

        var body: some View {
            FieldView(text: $text, prompt: prompt, isError: isError)
        }
    }

    struct FieldView: View {
        @Binding var text: String
        let prompt: String
        let isError: Bool

        var body: some View {
            if isError {
                DS.FieldRow(field) { DS.FormTextField(text: $0, prompt: prompt.isEmpty ? nil : prompt) }
            } else {
                DS.FormTextField(text: $text, prompt: prompt.isEmpty ? nil : prompt)
            }
        }

        private var field: Binding<DK.FormField<String>> {
            Binding(
                get: { DK.FormField(title: "Title", value: text, supportText: .error("Invalid value")) },
                set: { text = $0.value }
            )
        }
    }

    struct Playground: View {
        @State private var prompt = "Name"
        @State private var text = ""
        @State private var isError = false

        var body: some View {
            PlaygroundLayout(snippet: snippet) {
                FieldView(text: $text, prompt: prompt, isError: isError)
            } controls: {
                TextField("Prompt", text: $prompt)
                TextField("Text", text: $text)
                Toggle("Error", isOn: $isError)
            }
        }

        private var snippet: String {
            let field = "DS.FormTextField(text: $text, prompt: \(prompt.isEmpty ? "nil" : "\"\(prompt.snippetLiteral)\""))"
            guard isError else { return field }
            return "DS.FieldRow($field) { \(field) }  // field.supportText: .error(\"Invalid value\")"
        }
    }
}
