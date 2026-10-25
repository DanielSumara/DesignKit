import DesignKit

extension DS.Theme.SemanticTokens {
    public struct Radius: Equatable, Sendable {
        public internal(set) var small: Value
        public internal(set) var medium: Value
        public internal(set) var large: Value
        public internal(set) var xLarge: Value
    }
}

extension DS.Theme.SemanticTokens.Radius {
    public struct Value: Equatable, Sendable {
        let primitive: DS.Theme.RadiusPrimitive

        init(_ primitive: DS.Theme.RadiusPrimitive) {
            self.primitive = primitive
        }
    }
}
