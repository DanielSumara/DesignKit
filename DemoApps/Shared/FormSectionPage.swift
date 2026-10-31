import DesignKit
@_spi(Showcase) import DesignSystem
import SwiftUI

@MainActor
internal struct FormSectionPage: Page {
    let id = "form-section"
    let title = "Form Section"
    let section = Section.organisms

    var content: some View {
        PageContent(title: title)
    }
}

private extension FormSectionPage {
    static let properties = [
        ComponentProperty(name: "title", type: "String?", defaultValue: "none, required argument"),
        ComponentProperty(name: "footer", type: "String?", defaultValue: "nil"),
        ComponentProperty(name: "content", type: "@ViewBuilder () -> Content", defaultValue: "none, required")
    ]

    static let frameHeight: CGFloat = 320

    struct PageContent: View {
        let title: String
        @Environment(PlaygroundEnvironment.self) private var playgroundEnvironment

        var body: some View {
            ComponentPageView(
                title: title,
                properties: FormSectionPage.properties,
                tokens: playgroundEnvironment.componentTokens(of: "fieldRow"),
                playgroundIntro: "Playground: title, footer and one to three rows, shown inside a Form, "
                    + "with the shared environment and the code. Empty title and footer are omitted.",
                variantsIntro: "Variants: title and footer, title only, footer only, neither, in light and dark.",
                configurationIntro: "Configuration: properties with their defaults, "
                    + "component tokens with their alias chains.",
                playground: { Playground() },
                variants: {
                    ComponentVariant(name: "Title and footer") {
                        Sample(title: "Details", footer: "Footer of the section", rows: 2)
                    }
                    ComponentVariant(name: "Title only") {
                        Sample(title: "Details", footer: "", rows: 2)
                    }
                    ComponentVariant(name: "Footer only") {
                        Sample(title: "", footer: "Footer of the section", rows: 2)
                    }
                    ComponentVariant(name: "Neither") {
                        Sample(title: "", footer: "", rows: 2)
                    }
                }
            )
        }
    }

    struct Sample: View {
        let title: String
        let footer: String
        let rows: Int
        @State private var values = ["Groceries", "10", "Home"]

        var body: some View {
            DS.Form {
                DS.FormSection(title, footer: footer) {
                    ForEach(0..<rows, id: \.self) { index in
                        DS.FieldRow(field(index)) { DS.FormTextField(text: $0) }
                    }
                }
            }
            .frame(height: FormSectionPage.frameHeight)
        }

        private func field(_ index: Int) -> Binding<DK.FormField<String>> {
            Binding(
                get: { DK.FormField(title: "Field \(index + 1)", value: values[index]) },
                set: { values[index] = $0.value }
            )
        }
    }

    struct Playground: View {
        @State private var title = "Details"
        @State private var footer = "Footer of the section"
        @State private var rows = 2

        var body: some View {
            PlaygroundLayout(snippet: snippet) {
                Sample(title: title, footer: footer, rows: rows)
            } controls: {
                TextField("Title", text: $title)
                TextField("Footer", text: $footer)
                LabeledContent("Rows") {
                    Picker("Rows", selection: $rows) {
                        ForEach(1...3, id: \.self) { Text("\($0)").tag($0) }
                    }
                    .labelsHidden()
                }
            }
        }

        private var snippet: String {
            let titleLiteral = title.isEmpty ? "nil" : "\"\(title.snippetLiteral)\""
            let footerArgument = footer.isEmpty ? "" : ", footer: \"\(footer.snippetLiteral)\""
            let lines = (1...rows).map { "    DS.FieldRow($field\($0)) { DS.FormTextField(text: $0) }" }
            return "DS.FormSection(\(titleLiteral)\(footerArgument)) {\n" + lines.joined(separator: "\n") + "\n}"
        }
    }
}
