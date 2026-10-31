import DesignKit
import SwiftUI

extension DS.Theme.Components {
    public struct SupportTextColors: Equatable, Sendable {
        var footnote: ColorToken.Token
        var message: ColorToken.Token
        var error: ColorToken.Token

        public func color(_ text: DK.SupportText) -> Color {
            Color(mds: token(of: text))
        }

        func token(of text: DK.SupportText) -> ColorToken.Token {
            switch text {
            case .footnote: footnote
            case .message: message
            case .error: error
            }
        }
    }
}
