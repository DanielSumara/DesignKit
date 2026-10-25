import DesignKit
import SwiftUI

internal struct EdgeCaseIcon: View {
    @MDS(\.edgeCase) private var configuration
    let icon: DK.Icon

    var body: some View {
        content
            .frame(width: configuration.iconSize.points, height: configuration.iconSize.points)
            .accessibilityHidden(true)
    }

    @ViewBuilder
    private var content: some View {
        switch icon {
        case .symbol(let name):
            Image(systemName: name)
                .resizable()
                .scaledToFit()
        case .image(let data):
            if let image = EdgeCaseImage.decode(data) {
                Image(decorative: image, scale: 1)
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: configuration.imageRadius.points, style: .continuous))
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(mds: \.secondary)
            }
        case .monogram(let initials, let tint):
            Text(verbatim: initials)
                .font(mds: \.semibold, \.title2)
                .foregroundStyle(DS.Theme.TokenColor(group: \.onBackground, token: tint.foregroundToken))
                .lineLimit(1)
                .minimumScaleFactor(Self.minimumMonogramScale)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(DS.Theme.TokenColor(group: \.background, token: tint.backgroundToken), in: Circle())
        }
    }

    private static let minimumMonogramScale: CGFloat = 0.01
}
