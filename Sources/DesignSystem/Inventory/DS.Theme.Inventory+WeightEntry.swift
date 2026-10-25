import SwiftUI

extension DS.Theme.Inventory {
    @_spi(Showcase) public struct WeightEntry: Sendable {
        public let name: String
        public let path: KeyPath<DS.Theme.SemanticTokens.Typography.Weight, Font.Weight> & Sendable
    }

    @_spi(Showcase) public static var weightEntries: [WeightEntry] {
        let all = DS.Theme.SemanticTokens.Typography.Weight.all
        let stored = Set(Mirror(reflecting: DS.Theme.SemanticTokens.Typography.Weight()).children.compactMap(\.label))
        let listed = Set(all.map(\.name))
        precondition(stored == listed, "Unmapped typography weights \(stored.symmetricDifference(listed).sorted().joined(separator: ", "))")
        return all.map { WeightEntry(name: $0.name, path: $0.path) }
    }
}
