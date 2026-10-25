import SwiftUI

internal struct CompactSwitch<Compact: View, Regular: View>: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @ViewBuilder let compact: Compact
    @ViewBuilder let regular: Regular

    var body: some View {
        if horizontalSizeClass == .compact {
            compact
        } else {
            regular
        }
    }
}
