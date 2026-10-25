import DesignKit
@_spi(Showcase) import DesignSystem
import SwiftUI

@MainActor
internal struct StatusIconPage: Page {
    let id = "status-icon"
    let title = "Status Icon"
    let section = Section.atoms

    var content: some View {
        PageContent(title: title)
    }
}

private extension StatusIconPage {
    static let baseSize: CGFloat = 20

    static let statuses: [(name: String, status: DK.Status)] = [
        ("info", .info),
        ("success", .success),
        ("warning", .warning),
        ("error", .error)
    ]

    static let properties = [
        ComponentProperty(name: "status", type: "DK.Status", defaultValue: "none, required"),
        ComponentProperty(name: "size", type: "CGFloat", defaultValue: "none, required"),
        ComponentProperty(name: "label", type: "Text?", defaultValue: "nil")
    ]

    static func label(for name: String) -> Text {
        Text(verbatim: name.capitalized)
    }

    struct OwnerSize<Content: View>: View {
        let scales: Bool
        @ViewBuilder let content: (CGFloat) -> Content
        @Environment(PlaygroundEnvironment.self) private var playgroundEnvironment
        @ScaledMetric(relativeTo: .body) private var scaledMetric: CGFloat = StatusIconPage.baseSize

        var body: some View {
            content(size)
        }

        private var size: CGFloat {
            guard scales else { return StatusIconPage.baseSize }
            #if os(macOS)
            return StatusIconPage.baseSize * CGFloat(playgroundEnvironment.textSize.textSize.rawValue) / Self.percentBase
            #else
            return scaledMetric
            #endif
        }

        #if os(macOS)
        private static var percentBase: CGFloat { 100 }
        #endif
    }

    struct SizedIcon: View {
        @MDS private var mds
        let status: DK.Status
        let name: String
        let scales: Bool
        let showsLabel: Bool

        var body: some View {
            OwnerSize(scales: scales) { size in
                VStack(alignment: .leading, spacing: mds(spacing: \.small)) {
                    DS.StatusIcon(status, size: size, label: showsLabel ? StatusIconPage.label(for: name) : nil)
                    Text("Size: \(Int(size.rounded())) pt")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(showsLabel ? "VoiceOver: \(name.capitalized)" : "VoiceOver: skipped")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }

    struct IconRow: View {
        @MDS private var mds
        let scales: Bool
        let showsLabel: Bool

        var body: some View {
            WrappingLayout(spacing: mds(spacing: \.large)) {
                ForEach(StatusIconPage.statuses, id: \.name) { entry in
                    SizedIcon(status: entry.status, name: entry.name, scales: scales, showsLabel: showsLabel)
                }
            }
        }
    }

    struct PageContent: View {
        let title: String
        @Environment(PlaygroundEnvironment.self) private var playgroundEnvironment

        var body: some View {
            ComponentPageView(
                title: title,
                properties: StatusIconPage.properties,
                tokens: tokens,
                playgroundIntro: "Playground: status, label on or off, and whether the owner scales its size "
                    + "with the text size, with the shared environment and the code. "
                    + "Off, the icon stays 20 pt at any text size; on, the owner passes a larger size.",
                variantsIntro: "Variants: every status without and with a label, and the size at the current text size "
                    + "fixed and owner-scaled, in light and dark. "
                    + "The caption under each icon names the size and what VoiceOver does.",
                configurationIntro: "Configuration: properties with their defaults, "
                    + "component tokens with their alias chains.",
                playground: { Playground() },
                variants: {
                    ComponentVariant(name: "Label off") {
                        IconRow(scales: false, showsLabel: false)
                    }
                    ComponentVariant(name: "Label on") {
                        IconRow(scales: false, showsLabel: true)
                    }
                    ComponentVariant(name: "Size: fixed 20 pt") {
                        SizedIcon(status: .info, name: "info", scales: false, showsLabel: false)
                    }
                    ComponentVariant(name: "Size: scaled by the owner") {
                        SizedIcon(status: .info, name: "info", scales: true, showsLabel: false)
                    }
                }
            )
        }

        private var tokens: [ComponentToken] {
            playgroundEnvironment.componentTokens(of: "statusIcon")
        }
    }

    struct Playground: View {
        @State private var statusName = "info"
        @State private var showsLabel = false
        @State private var scales = false

        var body: some View {
            PlaygroundLayout(snippet: snippet) {
                SizedIcon(status: status, name: statusName, scales: scales, showsLabel: showsLabel)
            } controls: {
                LabeledContent("Status") {
                    Picker("Status", selection: $statusName) {
                        ForEach(StatusIconPage.statuses, id: \.name) { entry in
                            Text(entry.name).tag(entry.name)
                        }
                    }
                    .labelsHidden()
                }
                Toggle("Label", isOn: $showsLabel)
                Toggle("Owner scales size", isOn: $scales)
            }
        }

        private var status: DK.Status {
            StatusIconPage.statuses.first { $0.name == statusName }?.status ?? .info
        }

        private var snippet: String {
            let size = scales ? "scaledSize" : "20"
            let label = showsLabel ? ", label: Text(\"\(statusName.capitalized)\")" : ""
            return "DS.StatusIcon(.\(statusName), size: \(size)\(label))"
        }
    }
}
