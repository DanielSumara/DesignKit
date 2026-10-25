import SwiftUI

#if !os(macOS)
extension ShowcaseTextSize {
    static let all = [
        ShowcaseTextSize(title: "System", dynamicTypeSize: nil),
        ShowcaseTextSize(title: "Extra small", dynamicTypeSize: .xSmall),
        ShowcaseTextSize(title: "Small", dynamicTypeSize: .small),
        ShowcaseTextSize(title: "Medium", dynamicTypeSize: .medium),
        ShowcaseTextSize(title: "Large", dynamicTypeSize: .large),
        ShowcaseTextSize(title: "Extra large", dynamicTypeSize: .xLarge),
        ShowcaseTextSize(title: "Extra extra large", dynamicTypeSize: .xxLarge),
        ShowcaseTextSize(title: "Extra extra extra large", dynamicTypeSize: .xxxLarge),
        ShowcaseTextSize(title: "Accessibility 1", dynamicTypeSize: .accessibility1),
        ShowcaseTextSize(title: "Accessibility 2", dynamicTypeSize: .accessibility2),
        ShowcaseTextSize(title: "Accessibility 3", dynamicTypeSize: .accessibility3),
        ShowcaseTextSize(title: "Accessibility 4", dynamicTypeSize: .accessibility4),
        ShowcaseTextSize(title: "Accessibility 5", dynamicTypeSize: .accessibility5)
    ]
    static let `default` = all[0]
}
#endif
