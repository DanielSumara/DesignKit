import DesignKit
import SwiftUI

extension DS {
    public struct StatusIcon: View {
        @MDS(\.statusIcon) private var configuration
        private let status: DK.Status
        private let size: CGFloat
        private let label: Text?

        public init(_ status: DK.Status, size: CGFloat, label: Text? = nil) {
            self.status = status
            self.size = size
            self.label = label
        }

        public var body: some View {
            if let label {
                icon.accessibilityLabel(label)
            } else {
                icon.accessibilityHidden(true)
            }
        }

        private var icon: some View {
            Image(systemName: symbolName)
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .foregroundStyle(configuration.color(status))
        }

        private var symbolName: String {
            switch status {
            case .info: "info.circle.fill"
            case .success: "checkmark.circle.fill"
            case .warning: "exclamationmark.triangle.fill"
            case .error: "xmark.octagon.fill"
            }
        }
    }
}

private struct StatusIconVariants: View {
    @MDS private var mds

    var body: some View {
        HStack(spacing: mds(spacing: \.large)) {
            ForEach(DK.Status.allCases, id: \.self) { status in
                DS.StatusIcon(status, size: 24)
            }
            DS.StatusIcon(.info, size: 24, label: Text(verbatim: "Info"))
        }
        .padding(mds: \.large)
    }
}

#Preview("Light") {
    StatusIconVariants()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    StatusIconVariants()
        .preferredColorScheme(.dark)
}
