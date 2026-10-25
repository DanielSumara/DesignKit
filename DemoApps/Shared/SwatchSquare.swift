import DesignSystem
import SwiftUI

internal struct SwatchSquare<Fill: View>: View {
    @MDS private var mds
    @ViewBuilder let fill: Fill

    var body: some View {
        fill
            .frame(width: mds(spacing: \.xLarge), height: mds(spacing: \.xLarge))
            .clipShape(mds: \.small)
            .border(mds: \.subtle, width: \.thin, cornerRadius: \.small)
    }
}
