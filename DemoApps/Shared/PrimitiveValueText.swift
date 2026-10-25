@_spi(Showcase) import DesignSystem
import Foundation

internal enum PrimitiveValueText {
    static func text(of value: DS.Theme.Inventory.PrimitiveValue) -> String {
        switch value {
        case .points(let points): "\(points.formatted(.number.locale(Locale(identifier: "en")))) pt"
        case .milliseconds(let milliseconds): "\(milliseconds) ms"
        case .percent(let percent): "\(percent) %"
        case .srgb, .system: ""
        }
    }
}
