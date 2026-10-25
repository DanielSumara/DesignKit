import DesignSystem
import Observation

@MainActor
@Observable
internal final class PlaygroundEnvironment {
    var appearance: PlaygroundAppearance = .system
    var theme: ShowcaseTheme = .standard
    var amendment: ShowcaseAmendment = .plain
    var textSize: ShowcaseTextSize = .default

    var resolvedTheme: DS.Theme {
        amendment.apply(to: theme.theme)
    }
}
