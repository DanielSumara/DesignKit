import SwiftUI

internal struct AppearancePicker: View {
    @Environment(PlaygroundEnvironment.self) private var playgroundEnvironment

    var body: some View {
        @Bindable var playgroundEnvironment = playgroundEnvironment
        LabeledContent("Appearance") {
            Picker("Appearance", selection: $playgroundEnvironment.appearance) {
                ForEach(PlaygroundAppearance.allCases) { appearance in
                    Text(appearance.title).tag(appearance)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
        }
    }
}
