extension DS.Theme.Inventory {
    @_spi(Showcase) public struct SemanticEntry: Equatable, Sendable {
        public let kind: SemanticKind
        public let group: String
        public let name: String
        public let value: SemanticValue
    }
}
