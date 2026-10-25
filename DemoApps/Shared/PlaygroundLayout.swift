import SwiftUI

internal struct PlaygroundLayout<Preview: View, Controls: View>: View {
    let snippet: String
    @ViewBuilder let preview: () -> Preview
    @ViewBuilder let controls: () -> Controls

    @Environment(PlaygroundEnvironment.self) private var playgroundEnvironment

    var body: some View {
        VStack(alignment: .leading) {
            AppearanceSurface(colorScheme: playgroundEnvironment.appearance.colorScheme, content: preview)
            Text("Controls").font(.headline)
            controls()
            Text("Environment").font(.headline)
            AppearancePicker()
            Text("Code").font(.headline)
            Text(snippet)
                .font(.body.monospaced())
                .textSelection(.enabled)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
