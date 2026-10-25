extension DS.Theme.Inventory {
    @_spi(Showcase) public enum SemanticKind: Equatable, Sendable {
        case color
        case spacing
        case typography
        case radius
        case borderWidth
        case motion
    }
}
