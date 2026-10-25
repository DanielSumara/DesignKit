import DesignKit
@_spi(Showcase) import DesignSystem
import SwiftUI

@MainActor
internal struct EdgeCasePage: Page {
    let id = "edge-case"
    let title = "Edge Case"
    let section = Section.molecules

    var content: some View {
        PageContent(title: title)
    }
}

private extension EdgeCasePage {
    enum IconKind: String, CaseIterable {
        case symbol
        case image
        case undecodable
        case monogram
    }

    static let tints: [(name: String, tint: DK.AccentTint)] = [
        ("brand", .brand),
        ("info", .info),
        ("success", .success),
        ("warning", .warning),
        ("critical", .critical)
    ]

    static let roles: [(name: String, role: DK.ActionButton.Role?)] = [
        ("none", nil),
        ("primary", .primary),
        ("destructive", .destructive),
        ("cancel", .cancel)
    ]

    static let undecodableBytes = Data([0x00, 0x01, 0x02, 0x03, 0x04])

    static let sampleImage: Data = {
        guard let url = Bundle.main.url(forResource: "EdgeCaseSample", withExtension: "png"),
              let data = try? Data(contentsOf: url) else {
            return Data()
        }
        return data
    }()

    static let properties = [
        ComponentProperty(name: "edgeCase", type: "DK.EdgeCase", defaultValue: "none, required"),
        ComponentProperty(name: "edgeCase.icon", type: "DK.Icon", defaultValue: "none, required"),
        ComponentProperty(name: "edgeCase.title", type: "String", defaultValue: "none, required"),
        ComponentProperty(name: "edgeCase.message", type: "String", defaultValue: "none, required"),
        ComponentProperty(name: "edgeCase.actions", type: "[DK.ActionButton]", defaultValue: "[]")
    ]

    static func tint(named name: String) -> DK.AccentTint {
        tints.first { $0.name == name }?.tint ?? .brand
    }

    static func role(named name: String) -> DK.ActionButton.Role? {
        roles.first { $0.name == name }?.role
    }

    static func icon(kind: IconKind, symbol: String, initials: String, tintName: String) -> DK.Icon {
        switch kind {
        case .symbol: .symbol(symbol)
        case .image: .image(sampleImage)
        case .undecodable: .image(undecodableBytes)
        case .monogram: .monogram(initials, tint(named: tintName))
        }
    }

    static func sampleIcon(_ kind: IconKind) -> DK.Icon {
        icon(kind: kind, symbol: "wifi.slash", initials: "JK", tintName: "brand")
    }

    static func button(_ title: String, role: DK.ActionButton.Role?) -> DK.ActionButton {
        DK.ActionButton(title: title, role: role) {}
    }

    struct PageContent: View {
        let title: String
        @Environment(PlaygroundEnvironment.self) private var playgroundEnvironment

        var body: some View {
            ComponentPageView(
                title: title,
                properties: EdgeCasePage.properties,
                tokens: playgroundEnvironment.componentTokens(of: "edgeCase"),
                playgroundIntro: "Playground: the icon kind (symbol, image, undecodable image, monogram), "
                    + "the symbol, the initials and tint, the title and message, and zero to three actions "
                    + "with a role, with the shared environment and the code.",
                variantsIntro: "Variants: each icon kind, a monogram in each of the five tints, "
                    + "a long monogram, an empty message and actions, in light and dark.",
                configurationIntro: "Configuration: properties with their defaults, "
                    + "component tokens with their alias chains.",
                playground: { Playground() },
                variants: {
                    ComponentVariant(name: "Icon: symbol") {
                        DS.EdgeCaseView(DK.EdgeCase(
                            icon: .symbol("exclamationmark.triangle"),
                            title: "Error while reading data",
                            message: "Try again later."
                        ))
                    }
                    ComponentVariant(name: "Icon: image") {
                        DS.EdgeCaseView(DK.EdgeCase(
                            icon: .image(EdgeCasePage.sampleImage),
                            title: "Image",
                            message: "A 64 pt square with rounded corners."
                        ))
                    }
                    ComponentVariant(name: "Icon: undecodable image") {
                        DS.EdgeCaseView(DK.EdgeCase(
                            icon: .image(EdgeCasePage.undecodableBytes),
                            title: "Undecodable image",
                            message: "The photo symbol shows instead."
                        ))
                    }
                    ForEach(EdgeCasePage.tints, id: \.name) { entry in
                        ComponentVariant(name: "Monogram: \(entry.name)") {
                            DS.EdgeCaseView(DK.EdgeCase(
                                icon: .monogram("JK", entry.tint),
                                title: "Jan Kowalski",
                                message: "A 64 pt circle."
                            ))
                        }
                    }
                    ComponentVariant(name: "Monogram: ABCD scales to fit") {
                        DS.EdgeCaseView(DK.EdgeCase(
                            icon: .monogram("ABCD", .brand),
                            title: "Long monogram",
                            message: "The initials never wrap."
                        ))
                    }
                    ForEach(IconKind.allCases, id: \.self) { kind in
                        ComponentVariant(name: "\(kind.rawValue.capitalized): no message") {
                            DS.EdgeCaseView(DK.EdgeCase(icon: EdgeCasePage.sampleIcon(kind), title: "Nothing here", message: ""))
                        }
                        ComponentVariant(name: "\(kind.rawValue.capitalized): with actions") {
                            DS.EdgeCaseView(DK.EdgeCase(
                                icon: EdgeCasePage.sampleIcon(kind),
                                title: "No connection",
                                message: "Check the network and try again.",
                                actions: [
                                    EdgeCasePage.button("Try again", role: .primary),
                                    EdgeCasePage.button("Quit", role: nil)
                                ]
                            ))
                        }
                    }
                    ComponentVariant(name: "Actions: three with roles") {
                        DS.EdgeCaseView(DK.EdgeCase(
                            icon: .symbol("trash"),
                            title: "Delete data",
                            message: "This cannot be undone.",
                            actions: [
                                EdgeCasePage.button("Delete", role: .destructive),
                                EdgeCasePage.button("Export first", role: .primary),
                                EdgeCasePage.button("Cancel", role: .cancel)
                            ]
                        ))
                    }
                }
            )
        }
    }

    struct ActionDraft: Identifiable {
        let id: Int
        var title: String
        var roleName: String
    }

    struct Playground: View {
        @State private var kind = IconKind.symbol
        @State private var symbol = "exclamationmark.triangle"
        @State private var initials = "JK"
        @State private var tintName = "brand"
        @State private var title = "Error while reading data"
        @State private var message = "Try again later."
        @State private var count = 2
        @State private var drafts = [
            ActionDraft(id: 0, title: "Try again", roleName: "primary"),
            ActionDraft(id: 1, title: "Quit", roleName: "none"),
            ActionDraft(id: 2, title: "Cancel", roleName: "cancel")
        ]

        var body: some View {
            PlaygroundLayout(snippet: snippet) {
                DS.EdgeCaseView(edgeCase)
            } controls: {
                LabeledContent("Icon") {
                    Picker("Icon", selection: $kind) {
                        ForEach(IconKind.allCases, id: \.self) { Text($0.rawValue).tag($0) }
                    }
                    .labelsHidden()
                }
                if kind == .symbol {
                    TextField("Symbol", text: $symbol)
                }
                if kind == .monogram {
                    TextField("Initials", text: $initials)
                    LabeledContent("Tint") {
                        Picker("Tint", selection: $tintName) {
                            ForEach(EdgeCasePage.tints, id: \.name) { Text($0.name).tag($0.name) }
                        }
                        .labelsHidden()
                    }
                }
                TextField("Title", text: $title)
                TextField("Message", text: $message)
                LabeledContent("Actions") {
                    Picker("Actions", selection: $count) {
                        ForEach(0...3, id: \.self) { Text("\($0)").tag($0) }
                    }
                    .labelsHidden()
                }
                ForEach($drafts.prefix(count)) { $draft in
                    TextField("Action \(draft.id + 1) title", text: $draft.title)
                    LabeledContent("Role") {
                        Picker("Role", selection: $draft.roleName) {
                            ForEach(EdgeCasePage.roles, id: \.name) { Text($0.name).tag($0.name) }
                        }
                        .labelsHidden()
                    }
                }
            }
        }

        private var edgeCase: DK.EdgeCase {
            DK.EdgeCase(
                icon: EdgeCasePage.icon(kind: kind, symbol: symbol, initials: initials, tintName: tintName),
                title: title,
                message: message,
                actions: drafts.prefix(count).map {
                    EdgeCasePage.button($0.title, role: EdgeCasePage.role(named: $0.roleName))
                }
            )
        }

        private var iconSnippet: String {
            switch kind {
            case .symbol: ".symbol(\"\(symbol.snippetLiteral)\")"
            case .image: ".image(data)"
            case .undecodable: ".image(Data([0x00, 0x01, 0x02, 0x03, 0x04]))"
            case .monogram: ".monogram(\"\(initials.snippetLiteral)\", .\(tintName))"
            }
        }

        private var snippet: String {
            let actions = drafts.prefix(count).map { draft in
                let role = draft.roleName == "none" ? "" : ", role: .\(draft.roleName)"
                return "        DK.ActionButton(title: \"\(draft.title.snippetLiteral)\"\(role)) { }"
            }
            let actionsLine = actions.isEmpty ? "" : ",\n    actions: [\n" + actions.joined(separator: ",\n") + "\n    ]"
            return "DS.EdgeCaseView(DK.EdgeCase(\n"
                + "    icon: \(iconSnippet),\n"
                + "    title: \"\(title.snippetLiteral)\",\n"
                + "    message: \"\(message.snippetLiteral)\""
                + actionsLine + "\n))"
        }
    }
}
