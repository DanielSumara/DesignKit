import DesignKit

#if os(macOS)
extension ShowcaseTextSize {
    static let all = DK.TextSize.allCases.map { ShowcaseTextSize(title: "\($0.rawValue) %", textSize: $0) }
    static let `default` = all[DK.TextSize.allCases.firstIndex(of: .percent100) ?? 0]
}
#endif
