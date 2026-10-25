import DesignKit

extension DS.Theme.SemanticTokens {
    public struct BorderWidth: Equatable, Sendable {
        public internal(set) var thin: Value
        public internal(set) var medium: Value
        public internal(set) var thick: Value
    }
}

extension DS.Theme.SemanticTokens.BorderWidth {
    public struct Value: Equatable, Sendable {
        let primitive: DS.Theme.StrokePrimitive

        init(_ primitive: DS.Theme.StrokePrimitive) {
            self.primitive = primitive
        }
    }
}
