import SwiftUI

extension View {
    public func actionButtonStyle(_ style: DS.ActionButton.Style) -> some View {
        environment(\.actionButtonStyle, style)
    }
}
