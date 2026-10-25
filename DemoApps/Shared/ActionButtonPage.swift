import DesignKit
@_spi(Showcase) import DesignSystem
import SwiftUI

@MainActor
internal struct ActionButtonPage: Page {
    let id = "action-button"
    let title = "Action Button"
    let section = Section.atoms

    var content: some View {
        PageContent(title: title)
    }
}

private extension ActionButtonPage {
    typealias Role = DK.ActionButton.Role
    typealias ButtonState = DK.ActionButton.State
    typealias Style = DS.ActionButton.Style

    static let titleDefault = "Try again"
    static let oneSecond = 1
    static let threeSeconds = 3

    static let roles: [(name: String, role: Role?)] = [
        ("none", nil),
        ("primary", .primary),
        ("destructive", .destructive),
        ("cancel", .cancel)
    ]

    static let states: [(name: String, state: ButtonState)] = [
        ("normal", .normal),
        ("disabled", .disabled),
        ("loading", .loading)
    ]

    static let overrideStates: [(name: String, state: ButtonState)] = [
        ("normal", .normal),
        ("loading", .loading)
    ]

    static let styles: [(name: String, style: Style?)] = [
        ("none", nil),
        ("primary", .primary),
        ("secondary", .secondary),
        ("tertiary", .tertiary),
        ("success", .success),
        ("destructive", .destructive)
    ]

    static let durations: [(name: String, seconds: Int?)] = [
        ("instant", nil),
        ("1 s", oneSecond),
        ("3 s", threeSeconds)
    ]

    static let properties = [
        ComponentProperty(name: "data", type: "DK.ActionButton", defaultValue: "none, required"),
        ComponentProperty(name: "actionButtonStyle(_:)", type: "DS.ActionButton.Style (environment)", defaultValue: "none")
    ]

    static func button(title: String, role: Role?, state: ButtonState, seconds: Int? = nil) -> DK.ActionButton {
        DK.ActionButton(title: title, role: role, state: state) {
            if let seconds {
                try? await Task.sleep(for: .seconds(seconds))
            }
        }
    }

    struct StyleScope<Content: View>: View {
        let style: Style?
        @ViewBuilder let content: () -> Content

        var body: some View {
            if let style {
                content().actionButtonStyle(style)
            } else {
                content()
            }
        }
    }

    struct CountedButton: View {
        @MDS private var mds
        let title: String
        let role: Role?
        let state: ButtonState
        @State private var taps = 0

        var body: some View {
            VStack(alignment: .leading, spacing: mds(spacing: \.small)) {
                DS.ActionButton(data: DK.ActionButton(title: title, role: role, state: state) { taps += 1 })
                Text("Taps: \(taps)").font(.caption).foregroundStyle(.secondary)
            }
        }
    }

    struct KeyboardDemo: View {
        @MDS private var mds
        @State private var last = "none"

        var body: some View {
            VStack(alignment: .leading, spacing: mds(spacing: \.medium)) {
                ButtonRow {
                    DS.ActionButton(data: DK.ActionButton(title: "Save", role: .primary) { last = "primary" })
                    DS.ActionButton(data: DK.ActionButton(title: "Cancel", role: .cancel) { last = "cancel" })
                }
                Text("Last: \(last)").font(.caption).foregroundStyle(.secondary)
                Text("Press Return for primary and Esc for cancel; hardware keyboard on iPad.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }

    struct ButtonRow<Content: View>: View {
        @MDS private var mds
        @ViewBuilder let content: () -> Content

        var body: some View {
            WrappingLayout(spacing: mds(spacing: \.medium)) {
                content()
            }
        }
    }

    struct PageContent: View {
        let title: String
        @Environment(PlaygroundEnvironment.self) private var playgroundEnvironment

        var body: some View {
            ComponentPageView(
                title: title,
                properties: ActionButtonPage.properties,
                tokens: tokens,
                playgroundIntro: "Playground: title, role, state, style override and action duration, "
                    + "with the shared environment and the code. Return and Esc answer only here, "
                    + "on the keyboard demo below the preview: keep the playground role at none.",
                variantsIntro: "Variants: every role and state with a tap counter (loading and disabled stay at 0), "
                    + "and every style override with every role, normal and loading, in light and dark. "
                    + "The loading look shows its indicator in the label's color. "
                    + "Return and Esc are answered only on the Playground tab.",
                configurationIntro: "Configuration: properties with their defaults, "
                    + "component tokens with their alias chains.",
                playground: { Playground() },
                variants: {
                    ForEach(ActionButtonPage.roles, id: \.name) { role in
                        ComponentVariant(name: "Role: \(role.name)") {
                            ButtonRow {
                                ForEach(ActionButtonPage.states, id: \.name) { state in
                                    CountedButton(title: state.name, role: role.role, state: state.state)
                                }
                            }
                        }
                    }
                    ForEach(ActionButtonPage.styles, id: \.name) { style in
                        ComponentVariant(name: "Override: \(style.name)") {
                            StyleScope(style: style.style) {
                                ForEach(ActionButtonPage.overrideStates, id: \.name) { state in
                                    ButtonRow {
                                        ForEach(ActionButtonPage.roles, id: \.name) { role in
                                            DS.ActionButton(
                                                data: ActionButtonPage.button(
                                                    title: role.name,
                                                    role: role.role,
                                                    state: state.state
                                                )
                                            )
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            )
        }

        private var tokens: [ComponentToken] {
            playgroundEnvironment.componentTokens(of: "actionButton")
        }
    }

    struct Playground: View {
        @MDS private var mds
        @State private var title = ActionButtonPage.titleDefault
        @State private var roleName = "none"
        @State private var stateName = "normal"
        @State private var styleName = "none"
        @State private var durationName = "instant"

        var body: some View {
            PlaygroundLayout(snippet: snippet) {
                VStack(alignment: .leading, spacing: mds(spacing: \.medium)) {
                    StyleScope(style: style) {
                        DS.ActionButton(data: ActionButtonPage.button(title: title, role: role, state: state, seconds: seconds))
                    }
                    Divider()
                    KeyboardDemo()
                }
            } controls: {
                TextField("Title", text: $title)
                picker("Role", selection: $roleName, names: ActionButtonPage.roles.map(\.name))
                picker("State", selection: $stateName, names: ActionButtonPage.states.map(\.name))
                picker("Style override", selection: $styleName, names: ActionButtonPage.styles.map(\.name))
                picker("Action duration", selection: $durationName, names: ActionButtonPage.durations.map(\.name))
            }
        }

        private func picker(_ label: String, selection: Binding<String>, names: [String]) -> some View {
            LabeledContent(label) {
                Picker(label, selection: selection) {
                    ForEach(names, id: \.self) { name in
                        Text(name).tag(name)
                    }
                }
                .labelsHidden()
            }
        }

        private var role: Role? {
            ActionButtonPage.roles.first { $0.name == roleName }?.role
        }

        private var state: ButtonState {
            ActionButtonPage.states.first { $0.name == stateName }?.state ?? .normal
        }

        private var style: Style? {
            ActionButtonPage.styles.first { $0.name == styleName }?.style
        }

        private var seconds: Int? {
            ActionButtonPage.durations.first { $0.name == durationName }?.seconds ?? nil
        }

        private var snippet: String {
            let roleArgument = role == nil ? "" : "role: .\(roleName), "
            let button = "DS.ActionButton(data: DK.ActionButton(title: \"\(title.snippetLiteral)\", "
                + "\(roleArgument)state: .\(stateName)) { await work(\(durationName)) })"
            return styleName == "none" ? button : "\(button)\n    .actionButtonStyle(.\(styleName))"
        }
    }
}
