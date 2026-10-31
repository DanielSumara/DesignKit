import SwiftUI

extension EnvironmentValues {
    @Entry var fieldShowsErrorState: Bool = false

    public var fieldShowsError: Bool {
        fieldShowsErrorState
    }
}
