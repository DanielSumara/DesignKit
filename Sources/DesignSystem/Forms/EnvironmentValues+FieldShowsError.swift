import SwiftUI

extension EnvironmentValues {
    @Entry var fieldShowsErrorState: Bool = false

    public var fieldShowsError: Bool {
        fieldShowsErrorState
    }
}

private struct FieldShowsErrorPreview: View {
    @MDS private var mds
    @State private var text = "abc"

    var body: some View {
        VStack(spacing: mds(spacing: \.large)) {
            DS.FormTextField(text: $text, prompt: "Prompt")
            DS.FormTextField(text: $text, prompt: "Prompt")
                .environment(\.fieldShowsErrorState, true)
        }
        .padding(mds: \.large)
    }
}

#Preview("Light") {
    FieldShowsErrorPreview()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    FieldShowsErrorPreview()
        .preferredColorScheme(.dark)
}
