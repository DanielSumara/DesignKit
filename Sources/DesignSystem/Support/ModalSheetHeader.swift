import SwiftUI

internal struct ModalSheetHeader: View {
    let title: String
    let subtitle: String?

    @MDS private var mds
    @MDS(\.modalSheet) private var configuration

    var body: some View {
        VStack(alignment: .leading, spacing: configuration.headerSpacing.points) {
            Text(title)
                .font(mds: \.headline)
                .accessibilityAddTraits(.isHeader)
            if let subtitle, !subtitle.isEmpty {
                Text(subtitle)
                    .font(mds: \.subheadline)
                    .foregroundStyle(mds(color: \.foreground.secondary))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
