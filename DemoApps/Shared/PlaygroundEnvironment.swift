import Observation

@MainActor
@Observable
internal final class PlaygroundEnvironment {
    var appearance: PlaygroundAppearance = .system
}
