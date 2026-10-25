import DesignKit
import SwiftUI

internal struct ShowcaseTextSize: Hashable {
    let title: String
    #if os(macOS)
    let textSize: DK.TextSize
    #else
    let dynamicTypeSize: DynamicTypeSize?
    #endif
}
