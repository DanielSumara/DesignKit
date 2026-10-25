import SwiftUI

extension DS.Theme.Inventory {
    @_spi(Showcase) public struct WeightEntry: Sendable {
        public let name: String
        public let path: KeyPath<DS.Theme.SemanticTokens.Typography.Weight, Font.Weight> & Sendable
    }

    @_spi(Showcase) public static var weightEntries: [WeightEntry] {
        let entries = [
            WeightEntry(name: "regular", path: \.regular),
            WeightEntry(name: "medium", path: \.medium),
            WeightEntry(name: "semibold", path: \.semibold),
            WeightEntry(name: "bold", path: \.bold),
        ]
        let missing = ["regular", "medium", "semibold", "bold"].filter { name in
            !entries.contains { $0.name == name }
        }
        precondition(missing.isEmpty, "Unmapped typography weights \(missing.joined(separator: ", "))")
        return entries
    }
}
