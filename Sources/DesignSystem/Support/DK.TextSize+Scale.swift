import DesignKit
import SwiftUI

extension DK.TextSize {
    var scale: CGFloat {
        CGFloat(rawValue) / 100
    }

    var controlSize: ControlSize {
        switch self {
        case .percent85, .percent100: .regular
        case .percent115, .percent130, .percent150: .large
        case .percent175, .percent200: .extraLarge
        }
    }
}
