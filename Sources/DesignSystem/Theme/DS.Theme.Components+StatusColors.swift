import DesignKit
import SwiftUI

extension DS.Theme.Components {
    public struct StatusColors: Equatable, Sendable {
        typealias ColorToken = DS.Theme.Components.ColorToken.Token

        var info: ColorToken
        var success: ColorToken
        var warning: ColorToken
        var error: ColorToken

        public func color(_ status: DK.Status) -> Color {
            Color(mds: token(of: status))
        }

        func token(of status: DK.Status) -> ColorToken {
            switch status {
            case .info: info
            case .success: success
            case .warning: warning
            case .error: error
            }
        }
    }
}
