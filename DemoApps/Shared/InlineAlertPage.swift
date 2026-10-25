import DesignKit
@_spi(Showcase) import DesignSystem
import SwiftUI

@MainActor
internal struct InlineAlertPage: Page {
    let id = "inline-alert"
    let title = "Inline Alert"
    let section = Section.molecules

    var content: some View {
        PageContent(title: title)
    }
}

private extension InlineAlertPage {
    static let properties = [
        ComponentProperty(name: "notices", type: "[DK.InlineAlert.Notice]", defaultValue: "none, required"),
        ComponentProperty(name: "notice.status", type: "DK.Status", defaultValue: ".info"),
        ComponentProperty(name: "notice.title", type: "String", defaultValue: "none, required"),
        ComponentProperty(name: "notice.message", type: "String", defaultValue: "none, required")
    ]

    static func notice(_ name: String, title: String, message: String) -> DK.InlineAlert.Notice {
        DK.InlineAlert.Notice(status: status(named: name), title: title, message: message)
    }

    static func status(named name: String) -> DK.Status {
        StatusOption.all.first { $0.name == name }?.status ?? .info
    }

    static func alert(_ notices: [DK.InlineAlert.Notice]) -> DK.InlineAlert? {
        DK.InlineAlert(notices: notices)
    }

    struct PageContent: View {
        let title: String
        @Environment(PlaygroundEnvironment.self) private var playgroundEnvironment

        var body: some View {
            ComponentPageView(
                title: title,
                properties: InlineAlertPage.properties,
                tokens: playgroundEnvironment.componentTokens(of: "inlineAlert"),
                playgroundIntro: "Playground: one to three notices, each with a status, a title and a message, "
                    + "with the shared environment and the code. Empty titles and messages are omitted.",
                variantsIntro: "Variants: every status, mixed statuses where the most severe wins, "
                    + "an empty title, an empty message and a long message, in light and dark.",
                configurationIntro: "Configuration: properties with their defaults, "
                    + "component tokens with their alias chains.",
                playground: { Playground() },
                variants: {
                    ForEach(StatusOption.all, id: \.name) { entry in
                        ComponentVariant(name: "Status: \(entry.name)") {
                            AlertView(notices: [
                                DK.InlineAlert.Notice(status: entry.status, title: "Title", message: "Message of the notice.")
                            ])
                        }
                    }
                    ComponentVariant(name: "Two notices: info and warning") {
                        AlertView(notices: [
                            InlineAlertPage.notice("info", title: "Imported", message: "Your statement was imported."),
                            InlineAlertPage.notice("warning", title: "Check", message: "One transaction has no category.")
                        ])
                    }
                    ComponentVariant(name: "Three notices: error wins") {
                        AlertView(notices: [
                            InlineAlertPage.notice("success", title: "Saved", message: "The budget was saved."),
                            InlineAlertPage.notice("error", title: "Failed", message: "The bank connection failed."),
                            InlineAlertPage.notice("warning", title: "Check", message: "One transaction has no category.")
                        ])
                    }
                    ComponentVariant(name: "Empty title") {
                        AlertView(notices: [
                            InlineAlertPage.notice("info", title: "", message: "Only the message, on the first line.")
                        ])
                    }
                    ComponentVariant(name: "Empty message") {
                        AlertView(notices: [
                            InlineAlertPage.notice("success", title: "Only the title", message: "")
                        ])
                    }
                    ComponentVariant(name: "Long message") {
                        AlertView(notices: [
                            InlineAlertPage.notice(
                                "warning",
                                title: "Long message",
                                message: "A message that is long enough to wrap onto several lines "
                                    + "shows the icon staying centered on the first line only."
                            )
                        ])
                    }
                    ComponentVariant(name: "Nothing to draw") {
                        AlertView(notices: [
                            InlineAlertPage.notice("error", title: "", message: "")
                        ])
                    }
                }
            )
        }
    }

    struct AlertView: View {
        let notices: [DK.InlineAlert.Notice]

        var body: some View {
            if let data = InlineAlertPage.alert(notices) {
                DS.InlineAlert(data)
            }
        }
    }

    struct NoticeDraft: Identifiable {
        let id: Int
        var statusName: String
        var title: String
        var message: String
    }

    struct Playground: View {
        @State private var count = 2
        @State private var drafts = [
            NoticeDraft(id: 0, statusName: "info", title: "Imported", message: "Your statement was imported."),
            NoticeDraft(id: 1, statusName: "warning", title: "Check", message: "One transaction has no category."),
            NoticeDraft(id: 2, statusName: "error", title: "Failed", message: "The bank connection failed.")
        ]

        var body: some View {
            PlaygroundLayout(snippet: snippet) {
                AlertView(notices: notices)
            } controls: {
                LabeledContent("Notices") {
                    Picker("Notices", selection: $count) {
                        ForEach(1...3, id: \.self) { Text("\($0)").tag($0) }
                    }
                    .labelsHidden()
                }
                ForEach($drafts.prefix(count)) { $draft in
                    LabeledContent("Notice \(draft.id + 1)") {
                        Picker("Status", selection: $draft.statusName) {
                            ForEach(StatusOption.all, id: \.name) { Text($0.name).tag($0.name) }
                        }
                        .labelsHidden()
                    }
                    TextField("Title", text: $draft.title)
                    TextField("Message", text: $draft.message)
                }
            }
        }

        private var notices: [DK.InlineAlert.Notice] {
            drafts.prefix(count).map {
                InlineAlertPage.notice($0.statusName, title: $0.title, message: $0.message)
            }
        }

        private var snippet: String {
            let lines = drafts.prefix(count).map { draft in
                "    .init(status: .\(draft.statusName), title: \"\(draft.title.snippetLiteral)\", "
                    + "message: \"\(draft.message.snippetLiteral)\")"
            }
            return "DS.InlineAlert(DK.InlineAlert(\n" + lines.joined(separator: ",\n") + "\n))"
        }
    }
}
