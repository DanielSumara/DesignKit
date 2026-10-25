import DesignSystem
import SwiftUI

internal struct FoundationsPageShell<Content: View>: View {
    let showsTextSize: Bool
    @ViewBuilder let content: Content
    @MDS private var mds

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                EnvironmentControls(showsAppearance: false, showsTextSize: showsTextSize)
                    .padding()
                content
                    .padding(mds: \.large)
                    .showcaseEnvironment(includesTextSize: showsTextSize)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
