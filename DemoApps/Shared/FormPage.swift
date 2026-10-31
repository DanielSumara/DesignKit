import DesignKit
@_spi(Showcase) import DesignSystem
import SwiftUI

@MainActor
internal struct FormPage: Page {
    let id = "form"
    let title = "Form"
    let section = Section.templates

    var content: some View {
        PageContent(title: title)
    }
}

private extension FormPage {
    static let properties = [
        ComponentProperty(name: "content", type: "@ViewBuilder () -> Content", defaultValue: "none, required")
    ]

    static let frameHeight: CGFloat = 280
    static let titles = ["Name", "Amount", "Category", "Notes", "Account", "Tags"]

    struct PageContent: View {
        let title: String
        @Environment(PlaygroundEnvironment.self) private var playgroundEnvironment

        var body: some View {
            ComponentPageView(
                title: title,
                properties: FormPage.properties,
                tokens: playgroundEnvironment.componentTokens(of: "fieldRow"),
                playgroundIntro: "Playground: two sections of three fields in a frame shorter than the form. "
                    + "Toggles leave out the third field, disable the form, and make the second field optional "
                    + "with an error. Tab moves to the next field; the log lists every onFocusChange call.",
                variantsIntro: "Variants: the default form, the form disabled, and the second field optional "
                    + "with an error, in light and dark.",
                configurationIntro: "Configuration: properties with their defaults, "
                    + "component tokens with their alias chains.",
                playground: { Playground() },
                variants: {
                    ComponentVariant(name: "Default") {
                        Sample(leaveOutThird: false, isDisabled: false, secondHasError: false, log: nil)
                    }
                    ComponentVariant(name: "Disabled") {
                        Sample(leaveOutThird: false, isDisabled: true, secondHasError: false, log: nil)
                    }
                    ComponentVariant(name: "Second field optional with error") {
                        Sample(leaveOutThird: false, isDisabled: false, secondHasError: true, log: nil)
                    }
                }
            )
        }
    }

    struct Sample: View {
        let leaveOutThird: Bool
        let isDisabled: Bool
        let secondHasError: Bool
        let log: FocusLog?
        @State private var values = ["Groceries", "10", "Home", "", "Cash", "Food"]

        var body: some View {
            VStack(alignment: .leading) {
                DS.Form {
                    DS.FormSection("Details", footer: "Footer of the first section") {
                        row(0)
                        row(1)
                        if !leaveOutThird {
                            row(2)
                        }
                    }
                    DS.FormSection("More") {
                        row(3)
                        row(4)
                        row(5)
                    }
                }
                .disabled(isDisabled)
                .frame(height: FormPage.frameHeight)
                DS.ActionButton(data: DK.ActionButton(title: "Save", role: .primary) {})
            }
        }

        private func row(_ index: Int) -> some View {
            DS.FieldRow(field(index)) { DS.FormTextField(text: $0, prompt: FormPage.titles[index]) }
        }

        private func field(_ index: Int) -> Binding<DK.FormField<String>> {
            let isSecond = index == 1
            let title = FormPage.titles[index]
            let log = log
            return Binding(
                get: {
                    DK.FormField(
                        title: title,
                        value: values[index],
                        isOptional: isSecond && secondHasError,
                        supportText: isSecond && secondHasError ? .error("Invalid amount") : nil,
                        onFocusChange: { log?.record(title, focused: $0) }
                    )
                },
                set: { values[index] = $0.value }
            )
        }
    }

    struct Playground: View {
        @State private var leaveOutThird = false
        @State private var isDisabled = false
        @State private var secondHasError = false
        @State private var log = FocusLog()

        var body: some View {
            PlaygroundLayout(snippet: snippet) {
                Sample(leaveOutThird: leaveOutThird, isDisabled: isDisabled, secondHasError: secondHasError, log: log)
            } controls: {
                Toggle("Leave out the third field", isOn: $leaveOutThird)
                Toggle("Disabled", isOn: $isDisabled)
                Toggle("Second field optional with an error", isOn: $secondHasError)
                HStack {
                    Text("onFocusChange log").font(.headline)
                    Spacer()
                    Button("Clear") { log.clear() }
                }
                Text(log.lines.isEmpty ? "No calls yet" : log.lines.joined(separator: "\n"))
                    .font(.caption.monospaced())
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }

        private var snippet: String {
            FormFieldSnippet.make(
                title: "Amount",
                value: "10",
                isOptional: secondHasError,
                kind: secondHasError ? .error : .none,
                text: "Invalid amount"
            )
        }
    }
}
