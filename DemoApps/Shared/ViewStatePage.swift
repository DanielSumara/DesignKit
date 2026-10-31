import DesignKit
@_spi(Showcase) import DesignSystem
import SwiftUI

@MainActor
internal struct ViewStatePage: Page {
    let id = "view-state"
    let title = "View State"
    let section = Section.organisms

    var content: some View {
        PageContent(title: title)
    }
}

private extension ViewStatePage {
    static let properties = [
        ComponentProperty(name: "state", type: "DK.ViewState<Content>", defaultValue: "none, required"),
        ComponentProperty(name: "loadingLabel", type: "Text?", defaultValue: "nil (localized default)"),
        ComponentProperty(name: "content", type: "@ViewBuilder (Content) -> Loaded", defaultValue: "none, required")
    ]

    static let previewHeight: CGFloat = 220
    static let scrollHeight: CGFloat = 240
    static let shortMilliseconds = 100
    static let longMilliseconds = 1000
    static let shortReplay = Duration.milliseconds(shortMilliseconds)
    static let longReplay = Duration.milliseconds(longMilliseconds)

    enum StateKind: String, CaseIterable, Identifiable {
        case idle
        case loading
        case loaded
        case edgeCase = "edge case"

        var id: String { rawValue }
    }

    enum LabelKind: String, CaseIterable, Identifiable {
        case standard = "Default"
        case custom = "Custom"

        var id: String { rawValue }
    }

    static func sampleEdgeCase(actionCount: Int = 1) -> DK.EdgeCase {
        DK.EdgeCase(
            icon: .symbol("exclamationmark.triangle"),
            title: "Error while reading data",
            message: "Try again later.",
            actions: Array(actions.prefix(actionCount))
        )
    }

    static let actions = [
        DK.ActionButton(title: "Try again", role: .primary) {},
        DK.ActionButton(title: "Quit") {}
    ]

    struct SampleContent: View {
        let value: String
        @State private var text = ""

        var body: some View {
            VStack(alignment: .leading) {
                Text(value)
                TextField("Type here", text: $text)
            }
        }
    }

    struct PageContent: View {
        let title: String
        @Environment(PlaygroundEnvironment.self) private var playgroundEnvironment

        var body: some View {
            ComponentPageView(
                title: title,
                properties: ViewStatePage.properties,
                tokens: playgroundEnvironment.componentTokens(of: "viewState"),
                playgroundIntro: "Playground: the state (idle, loading, loaded, edge case), the loading label "
                    + "(default or custom), the edge case (symbol, title, message, zero to two actions), "
                    + "a replay of loading followed by loaded after 0.1 s or 1 s and the count of the view's "
                    + ".task runs, with the shared environment and the code.",
                variantsIntro: "Variants: idle, loading, loaded, an edge case and the content-less form in loading, "
                    + "in light and dark; loading and an edge case inside a vertical scroll view. "
                    + "The loading look appears after 150 ms.",
                configurationIntro: "Configuration: properties with their defaults, "
                    + "component tokens with their alias chains.",
                playground: { Playground() },
                variants: {
                    ComponentVariant(name: "Idle") {
                        DS.ViewState(DK.ViewState<String>.idle) { SampleContent(value: $0) }
                    }
                    ComponentVariant(name: "Loading") {
                        DS.ViewState(DK.ViewState<String>.loading) { SampleContent(value: $0) }
                    }
                    ComponentVariant(name: "Loaded") {
                        DS.ViewState(DK.ViewState<String>.loaded("Loaded content")) { SampleContent(value: $0) }
                    }
                    ComponentVariant(name: "Edge case with one action") {
                        DS.ViewState(DK.ViewState<String>.edgeCase(ViewStatePage.sampleEdgeCase())) {
                            SampleContent(value: $0)
                        }
                    }
                    ComponentVariant(name: "Content-less form: loading") {
                        DS.ViewState(DK.ViewState<Never>.loading)
                    }
                    ComponentVariant(name: "Loading in a vertical scroll view") {
                        ScrollView {
                            DS.ViewState(DK.ViewState<String>.loading) { SampleContent(value: $0) }
                        }
                        .frame(height: ViewStatePage.scrollHeight)
                    }
                    ComponentVariant(name: "Edge case in a vertical scroll view") {
                        ScrollView {
                            DS.ViewState(DK.ViewState<String>.edgeCase(ViewStatePage.sampleEdgeCase())) {
                                SampleContent(value: $0)
                            }
                        }
                        .frame(height: ViewStatePage.scrollHeight)
                    }
                }
            )
        }
    }

    struct Playground: View {
        @State private var kind = StateKind.loaded
        @State private var labelKind = LabelKind.standard
        @State private var label = "Fetching your data…"
        @State private var symbol = "exclamationmark.triangle"
        @State private var edgeTitle = "Error while reading data"
        @State private var edgeMessage = "Try again later."
        @State private var actionCount = 1
        @State private var taskRuns = 0
        @State private var replayTask: Task<Void, Never>?
        @State private var replayKind: StateKind?

        var body: some View {
            PlaygroundLayout(snippet: snippet) {
                DS.ViewState(state, loadingLabel: loadingLabel) { SampleContent(value: $0) }
                    .task { taskRuns += 1 }
                    .frame(minHeight: ViewStatePage.previewHeight)
                    .onChange(of: kind) { _, new in
                        if replayKind == new {
                            replayKind = nil
                        } else {
                            cancelReplay()
                        }
                    }
                    .onDisappear { cancelReplay() }
            } controls: {
                LabeledContent("State") {
                    Picker("State", selection: $kind) {
                        ForEach(StateKind.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .labelsHidden()
                }
                LabeledContent("Loading label") {
                    Picker("Loading label", selection: $labelKind) {
                        ForEach(LabelKind.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                }
                if labelKind == .custom {
                    TextField("Label", text: $label)
                }
                TextField("Symbol", text: $symbol)
                TextField("Title", text: $edgeTitle)
                TextField("Message", text: $edgeMessage)
                LabeledContent("Actions") {
                    Picker("Actions", selection: $actionCount) {
                        ForEach(0...2, id: \.self) { Text("\($0)").tag($0) }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                }
                Button("Replay: loaded after 0.1 s") { replay(after: ViewStatePage.shortReplay) }
                Button("Replay: loaded after 1 s") { replay(after: ViewStatePage.longReplay) }
                Text("The .task runs of the view: \(taskRuns)")
            }
        }

        private var loadingLabel: Text? {
            labelKind == .custom ? Text(verbatim: label) : nil
        }

        private var edgeCase: DK.EdgeCase {
            DK.EdgeCase(
                icon: .symbol(symbol),
                title: edgeTitle,
                message: edgeMessage,
                actions: Array(ViewStatePage.actions.prefix(actionCount))
            )
        }

        private var state: DK.ViewState<String> {
            switch kind {
            case .idle: .idle
            case .loading: .loading
            case .loaded: .loaded("Loaded content")
            case .edgeCase: .edgeCase(edgeCase)
            }
        }

        private func replay(after delay: Duration) {
            replayTask?.cancel()
            replayKind = kind == .loading ? nil : .loading
            kind = .loading
            replayTask = Task {
                try? await Task.sleep(for: delay)
                guard !Task.isCancelled else { return }
                replayKind = .loaded
                kind = .loaded
            }
        }

        private func cancelReplay() {
            replayTask?.cancel()
            replayTask = nil
            replayKind = nil
        }

        private var stateSnippet: String {
            switch kind {
            case .idle: "DK.ViewState<String>.idle"
            case .loading: "DK.ViewState<String>.loading"
            case .loaded: "DK.ViewState<String>.loaded(\"Loaded content\")"
            case .edgeCase: "DK.ViewState<String>.edgeCase(edgeCase)"
            }
        }

        private var edgeCaseSnippet: String {
            let actions = ViewStatePage.actions.prefix(actionCount).map { action in
                let role = action.role == nil ? "" : ", role: .primary"
                return "        DK.ActionButton(title: \"\(action.title.snippetLiteral)\"\(role)) { }"
            }
            let actionsLine = actions.isEmpty ? "" : ",\n    actions: [\n" + actions.joined(separator: ",\n") + "\n    ]"
            return "let edgeCase = DK.EdgeCase(\n"
                + "    icon: .symbol(\"\(symbol.snippetLiteral)\"),\n"
                + "    title: \"\(edgeTitle.snippetLiteral)\",\n"
                + "    message: \"\(edgeMessage.snippetLiteral)\""
                + actionsLine + "\n)\n\n"
        }

        private var snippet: String {
            let prefix = kind == .edgeCase ? edgeCaseSnippet : ""
            let labelArgument = labelKind == .custom ? ", loadingLabel: Text(\"\(label.snippetLiteral)\")" : ""
            return prefix
                + "DS.ViewState(\(stateSnippet)\(labelArgument)) { value in\n"
                + "    Text(value)\n"
                + "}\n"
                + ".task { await load() }"
        }
    }
}
