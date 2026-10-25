import DesignKit

extension DS.Theme.SemanticTokens {
    public struct Spacing: Equatable, Sendable {
        public internal(set) var xxSmall: Value
        public internal(set) var xSmall: Value
        public internal(set) var small: Value
        public internal(set) var medium: Value
        public internal(set) var large: Value
        public internal(set) var xLarge: Value
        public internal(set) var xxLarge: Value
    }
}

extension DS.Theme.SemanticTokens.Spacing {
    public struct Value: Equatable, Sendable {
        let primitive: DS.Theme.SpacePrimitive

        init(_ primitive: DS.Theme.SpacePrimitive) {
            self.primitive = primitive
        }
    }
}
