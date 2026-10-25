import SwiftUI

internal struct PageAnatomyPlayground: View {
    static let sampleTextDefault = "The quick brown fox jumps over the lazy dog"

    @State private var sampleText = Self.sampleTextDefault

    var body: some View {
        PlaygroundLayout(snippet: "Text(\"\(escaped)\")") {
            Text(sampleText)
        } controls: {
            TextField("Sample text", text: $sampleText)
        }
    }

    private var escaped: String {
        sampleText
            .replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "\"", with: "\\\"")
    }
}
