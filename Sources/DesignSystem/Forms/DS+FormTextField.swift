import SwiftUI

extension DS {
    public struct FormTextField: View {
        @MDS(\.fieldRow) private var configuration
        @Environment(\.fieldShowsError) private var showsError
        @Environment(\.fieldIsFocused) private var isFocused
        @Binding private var text: String
        private let prompt: String?

        public init(text: Binding<String>, prompt: String? = nil) {
            _text = text
            self.prompt = prompt
        }

        public var body: some View {
            TextField(text: $text, prompt: prompt.map { Text(verbatim: $0) }) {
                EmptyView()
            }
            .textFieldStyle(.roundedBorder)
            .focusEffectDisabled(showsError)
            .overlay {
                if showsError {
                    RoundedRectangle(cornerRadius: configuration.errorBorderRadius.points, style: .continuous)
                        .strokeBorder(configuration.errorBorderColor.color, lineWidth: configuration.errorBorderWidth.points)
                        .allowsHitTesting(false)
                }
            }
            .overlay {
                if showsError && isFocused {
                    RoundedRectangle(
                        cornerRadius: configuration.errorBorderRadius.points + configuration.errorFocusRingWidth.points,
                        style: .continuous
                    )
                    .strokeBorder(configuration.errorBorderColor.color, lineWidth: configuration.errorFocusRingWidth.points)
                    .padding(-configuration.errorFocusRingWidth.points)
                    .allowsHitTesting(false)
                }
            }
        }
    }
}

private struct FormTextFieldVariants: View {
    @MDS private var mds
    @State private var empty = ""
    @State private var typed = "Groceries"

    var body: some View {
        VStack(spacing: mds(spacing: \.large)) {
            DS.FormTextField(text: $empty, prompt: "Name")
            DS.FormTextField(text: $typed)
            DS.FormTextField(text: $typed, prompt: "Name")
                .environment(\.fieldShowsErrorState, true)
        }
        .padding(mds: \.large)
    }
}

#Preview("Light") {
    FormTextFieldVariants()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    FormTextFieldVariants()
        .preferredColorScheme(.dark)
}
