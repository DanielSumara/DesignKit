import DesignKit
import SwiftUI

internal struct EdgeCaseIcon: View {
    @MDS(\.edgeCase) private var configuration
    let icon: DK.Icon

    var body: some View {
        content
            .accessibilityHidden(true)
    }

    @ViewBuilder
    private var content: some View {
        switch icon {
        case .symbol(let name):
            Image(systemName: name)
                .foregroundStyle(mds: \.secondary)
        case .image(let data):
            if let image = EdgeCaseImage.decode(data) {
                Image(decorative: image, scale: 1)
                    .resizable()
                    .scaledToFill()
                    .frame(width: configuration.iconSize.points, height: configuration.iconSize.points)
                    .clipShape(RoundedRectangle(cornerRadius: configuration.imageRadius.points, style: .continuous))
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(mds: \.secondary)
                    .frame(width: configuration.iconSize.points, height: configuration.iconSize.points)
            }
        case .monogram(let initials, let tint):
            Text(verbatim: initials)
                .font(mds: \.semibold, \.title2)
                .foregroundStyle(DS.Theme.TokenColor(group: \.onBackground, token: tint.foregroundToken))
                .lineLimit(1)
                .minimumScaleFactor(Self.minimumMonogramScale)
                .frame(width: inscribedSide, height: inscribedSide)
                .frame(width: configuration.iconSize.points, height: configuration.iconSize.points)
                .background(DS.Theme.TokenColor(group: \.background, token: tint.backgroundToken), in: Circle())
        }
    }

    private var inscribedSide: CGFloat {
        configuration.iconSize.points / 2.0.squareRoot()
    }

    private static let minimumMonogramScale: CGFloat = 0.01
}
