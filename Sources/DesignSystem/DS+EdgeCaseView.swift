import DesignKit
import SwiftUI

extension DS {
    public struct EdgeCaseView: View {
        private let edgeCase: DK.EdgeCase

        public init(_ edgeCase: DK.EdgeCase) {
            self.edgeCase = edgeCase
        }

        public var body: some View {
            ContentUnavailableView {
                Label {
                    Text(edgeCase.title)
                        .font(mds: \.bold, \.title)
                } icon: {
                    EdgeCaseIcon(icon: edgeCase.icon)
                }
            } description: {
                if !edgeCase.message.isEmpty {
                    Text(edgeCase.message)
                        .font(mds: \.body)
                }
            } actions: {
                ForEach(edgeCase.actions) { item in
                    ActionButton(data: item)
                }
            }
        }
    }
}

private struct EdgeCaseVariants: View {
    @MDS private var mds

    private let actions = [
        DK.ActionButton(title: "Try again", role: .primary) {},
        DK.ActionButton(title: "Quit") {}
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: mds(spacing: \.large)) {
                DS.EdgeCaseView(DK.EdgeCase(
                    icon: .symbol("exclamationmark.triangle"),
                    title: "Error while reading data",
                    message: "Try again later.",
                    actions: actions
                ))
                DS.EdgeCaseView(DK.EdgeCase(icon: .monogram("JK", .brand), title: "Jan Kowalski", message: ""))
                DS.EdgeCaseView(DK.EdgeCase(icon: .monogram("WWWW", .warning), title: "Long monogram", message: "Scales to fit."))
                DS.EdgeCaseView(DK.EdgeCase(icon: .image(Data()), title: "Undecodable image", message: "Shows the fallback."))
            }
        }
    }
}

#Preview("Light") {
    EdgeCaseVariants()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    EdgeCaseVariants()
        .preferredColorScheme(.dark)
}
