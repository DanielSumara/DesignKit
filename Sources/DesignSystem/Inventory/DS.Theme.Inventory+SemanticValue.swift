extension DS.Theme.Inventory {
    @_spi(Showcase) public enum SemanticValue: Equatable, Sendable {
        case color(ColorAlias)
        case primitive(scale: String, name: String)
        case design(String)
    }
}
