import DesignKit
@_spi(Showcase) import DesignSystem
import SwiftUI

@MainActor
internal struct ModalSheetPage: Page {
    let id = "modal-sheet"
    let title = "Modal Sheet"
    let section = Section.templates

    var content: some View {
        PageContent(title: title)
    }
}

private extension ModalSheetPage {
    static let properties = [
        ComponentProperty(name: "title", type: "String", defaultValue: "none, required"),
        ComponentProperty(name: "subtitle", type: "String?", defaultValue: "nil"),
        ComponentProperty(name: "cancel", type: "DK.ActionButton", defaultValue: "none, required"),
        ComponentProperty(name: "confirm", type: "DK.ActionButton?", defaultValue: "nil"),
        ComponentProperty(name: "confirmsDiscard", type: "Bool", defaultValue: "false"),
        ComponentProperty(name: "width", type: "DS.ModalSheet.Width", defaultValue: ".standard"),
        ComponentProperty(name: "content", type: "@ViewBuilder () -> Content", defaultValue: "none, required")
    ]

    static let variantHeight: CGFloat = 320
    static let confirmSeconds = 2

    enum ActionState: String, CaseIterable, Identifiable {
        case normal
        case disabled
        case loading

        var id: String { rawValue }

        var state: DK.ActionButton.State {
            switch self {
            case .normal: .normal
            case .disabled: .disabled
            case .loading: .loading
            }
        }
    }

    enum SampleContent: String, CaseIterable, Identifiable {
        case fewRows = "Few rows"
        case longList = "Long list"

        var id: String { rawValue }

        var rowCount: Int {
            switch self {
            case .fewRows: 3
            case .longList: 40
            }
        }
    }

    struct Sheet: View {
        let data: DK.ModalSheet
        var width = DS.ModalSheet<SampleRows>.Width.standard
        var rowCount = 3

        var body: some View {
            DS.ModalSheet(data, width: width) {
                SampleRows(count: rowCount)
            }
        }
    }

    struct SampleRows: View {
        let count: Int

        var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(1...count, id: \.self) { index in
                        Text("Row \(index)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Divider()
                    }
                }
                .padding()
            }
        }
    }

    struct PageContent: View {
        let title: String
        @Environment(PlaygroundEnvironment.self) private var playgroundEnvironment

        var body: some View {
            ComponentPageView(
                title: title,
                properties: ModalSheetPage.properties,
                tokens: playgroundEnvironment.componentTokens(of: "modalSheet"),
                playgroundIntro: "Playground: a button presents the sheet. Controls set the title, subtitle, "
                    + "confirm action, each action's state, discard confirmation, width, the sample content "
                    + "and whether the confirm action lasts 2 s, with the shared environment and the code.",
                variantsIntro: "Variants: title only, with subtitle, with confirm action, with subtitle and "
                    + "confirm action, and with discard confirmation, in light and dark. "
                    + "Each sheet is drawn inline in a fixed frame.",
                configurationIntro: "Configuration: properties with their defaults, "
                    + "component tokens with their alias chains.",
                playground: { Playground() },
                variants: {
                    ComponentVariant(name: "Title only") {
                        VariantSheet(subtitle: nil, hasConfirm: false, confirmsDiscard: false)
                    }
                    ComponentVariant(name: "Subtitle") {
                        VariantSheet(subtitle: "Subtitle", hasConfirm: false, confirmsDiscard: false)
                    }
                    ComponentVariant(name: "Confirm action") {
                        VariantSheet(subtitle: nil, hasConfirm: true, confirmsDiscard: false)
                    }
                    ComponentVariant(name: "Subtitle and confirm action") {
                        VariantSheet(subtitle: "Subtitle", hasConfirm: true, confirmsDiscard: false)
                    }
                    ComponentVariant(name: "Confirms discard") {
                        VariantSheet(subtitle: "Subtitle", hasConfirm: true, confirmsDiscard: true)
                    }
                }
            )
        }
    }

    struct VariantSheet: View {
        let subtitle: String?
        let hasConfirm: Bool
        let confirmsDiscard: Bool

        var body: some View {
            Sheet(
                data: DK.ModalSheet(
                    title: "Title",
                    subtitle: subtitle,
                    cancel: DK.ActionButton(title: "Cancel") {},
                    confirm: hasConfirm ? DK.ActionButton(title: "Save") {} : nil,
                    confirmsDiscard: confirmsDiscard
                )
            )
            .frame(height: ModalSheetPage.variantHeight)
        }
    }

    struct Playground: View {
        @State private var isPresented = false
        @State private var title = "New category"
        @State private var subtitle = "Groceries"
        @State private var hasConfirm = true
        @State private var cancelState = ActionState.normal
        @State private var confirmState = ActionState.normal
        @State private var confirmsDiscard = false
        @State private var width = DS.ModalSheet<SampleRows>.Width.standard
        @State private var lastsTwoSeconds = true
        @State private var sampleContent = SampleContent.fewRows

        @Environment(PlaygroundEnvironment.self) private var playgroundEnvironment

        var body: some View {
            PlaygroundLayout(snippet: snippet) {
                Button("Present sheet") { isPresented = true }
                    .sheet(isPresented: $isPresented) {
                        Sheet(data: data, width: width, rowCount: sampleContent.rowCount)
                            .showcaseEnvironment()
                            .preferredColorScheme(playgroundEnvironment.appearance.colorScheme)
                    }
            } controls: {
                TextField("Title", text: $title)
                TextField("Subtitle (empty for none)", text: $subtitle)
                Toggle("Confirm action", isOn: $hasConfirm)
                LabeledContent("Cancel state") { statePicker("Cancel state", selection: $cancelState) }
                LabeledContent("Confirm state") { statePicker("Confirm state", selection: $confirmState) }
                    .disabled(!hasConfirm)
                Toggle("Confirms discard", isOn: $confirmsDiscard)
                LabeledContent("Width") {
                    Picker("Width", selection: $width) {
                        ForEach(DS.ModalSheet<SampleRows>.Width.allCases, id: \.self) { Text(widthName($0)).tag($0) }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                }
                Toggle("Confirm action lasts 2 s", isOn: $lastsTwoSeconds)
                    .disabled(!hasConfirm)
                LabeledContent("Sample content") {
                    Picker("Sample content", selection: $sampleContent) {
                        ForEach(SampleContent.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                }
            }
        }

        private var data: DK.ModalSheet {
            let lastsTwoSeconds = lastsTwoSeconds
            return DK.ModalSheet(
                title: title,
                subtitle: subtitle.isEmpty ? nil : subtitle,
                cancel: DK.ActionButton(title: "Cancel", state: cancelState.state) { isPresented = false },
                confirm: hasConfirm
                    ? DK.ActionButton(title: "Save", state: confirmState.state) {
                        if lastsTwoSeconds {
                            try? await Task.sleep(for: .seconds(ModalSheetPage.confirmSeconds))
                        }
                        isPresented = false
                    }
                    : nil,
                confirmsDiscard: confirmsDiscard
            )
        }

        private func statePicker(_ label: String, selection: Binding<ActionState>) -> some View {
            Picker(label, selection: selection) {
                ForEach(ActionState.allCases) { Text($0.rawValue).tag($0) }
            }
            .labelsHidden()
        }

        private func widthName(_ width: DS.ModalSheet<SampleRows>.Width) -> String {
            switch width {
            case .standard: "Standard"
            case .wide: "Wide"
            }
        }

        private var snippet: String {
            var lines = ["    title: \"\(title.snippetLiteral)\""]
            if !subtitle.isEmpty {
                lines.append("    subtitle: \"\(subtitle.snippetLiteral)\"")
            }
            lines.append("    cancel: DK.ActionButton(title: \"Cancel\"\(stateArgument(cancelState))) { … }")
            if hasConfirm {
                lines.append("    confirm: DK.ActionButton(title: \"Save\"\(stateArgument(confirmState))) { … }")
            }
            if confirmsDiscard {
                lines.append("    confirmsDiscard: true")
            }
            let widthArgument = width == .wide ? ", width: .wide" : ""
            return "DS.ModalSheet(\n  DK.ModalSheet(\n" + lines.joined(separator: ",\n")
                + "\n  )\(widthArgument)\n) { … }"
        }

        private func stateArgument(_ state: ActionState) -> String {
            state == .normal ? "" : ", state: .\(state.rawValue)"
        }
    }
}
