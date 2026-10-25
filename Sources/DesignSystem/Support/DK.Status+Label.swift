import DesignKit
import SwiftUI

extension DK.Status {
    var label: Text {
        switch self {
        case .info: Text("designSystem.statusIcon.info", bundle: .module)
        case .success: Text("designSystem.statusIcon.success", bundle: .module)
        case .warning: Text("designSystem.statusIcon.warning", bundle: .module)
        case .error: Text("designSystem.statusIcon.error", bundle: .module)
        }
    }
}
