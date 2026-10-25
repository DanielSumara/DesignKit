import SwiftUI

extension DS {
    public struct ActivityIndicator: View {
        @Environment(\.controlSize) private var controlSize
        @MDS(\.activityIndicator) private var configuration
        private let label: Text

        public init(label: Text) {
            self.label = label
        }

        public var body: some View {
            switch controlSize {
            case .large:
                placeholder(size: configuration.largePlaceholderSize.points)
            case .extraLarge:
                placeholder(size: configuration.extraLargePlaceholderSize.points)
            default:
                ProgressView()
                    .accessibilityLabel(label)
            }
        }

        private func placeholder(size: CGFloat) -> some View {
            Image(systemName: "progress.indicator")
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .foregroundStyle(mds: \.brand)
                .accessibilityLabel(label)
        }
    }
}

private struct ActivityIndicatorSizes: View {
    @MDS private var mds

    var body: some View {
        HStack(spacing: mds(spacing: \.large)) {
            ForEach(ControlSize.allCases, id: \.self) { size in
                DS.ActivityIndicator(label: Text(verbatim: "Loading"))
                    .controlSize(size)
            }
        }
        .padding(mds: \.large)
    }
}

#Preview("Light") {
    ActivityIndicatorSizes()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    ActivityIndicatorSizes()
        .preferredColorScheme(.dark)
}
