import SwiftUI

internal struct EnvironmentControls: View {
    var showsAppearance = true
    var showsTextSize = true

    @Environment(PlaygroundEnvironment.self) private var playgroundEnvironment

    var body: some View {
        @Bindable var playgroundEnvironment = playgroundEnvironment
        VStack(alignment: .leading) {
            if showsAppearance {
                AppearancePicker()
            }
            LabeledContent("Theme") {
                Picker("Theme", selection: $playgroundEnvironment.theme) {
                    ForEach(ShowcaseTheme.allCases) { theme in
                        Text(theme.title).tag(theme)
                    }
                }
                .labelsHidden()
            }
            LabeledContent("Amendment") {
                Picker("Amendment", selection: $playgroundEnvironment.amendment) {
                    ForEach(ShowcaseAmendment.allCases) { amendment in
                        Text(amendment.title).tag(amendment)
                    }
                }
                .pickerStyle(.segmented)
                .labelsHidden()
            }
            if showsTextSize {
                LabeledContent("Text size") {
                    Picker("Text size", selection: $playgroundEnvironment.textSize) {
                        ForEach(ShowcaseTextSize.all, id: \.self) { textSize in
                            Text(textSize.title).tag(textSize)
                        }
                    }
                    .labelsHidden()
                }
            }
        }
    }
}
