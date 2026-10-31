import SwiftUI

internal struct ViewStateLoadingLook: View {
    @MDS(\.viewState) private var configuration
    let label: Text

    var body: some View {
        VStack(spacing: configuration.labelSpacing.points) {
            DS.ActivityIndicator(label: label)
                .controlSize(.regular)
            label
                .font(mds: \.subheadline)
                .foregroundStyle(mds: \.secondary)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(label)
    }
}
