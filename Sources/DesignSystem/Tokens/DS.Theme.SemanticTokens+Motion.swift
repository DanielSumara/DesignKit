extension DS.Theme.SemanticTokens {
    public struct Motion: Equatable, Sendable {
        public internal(set) var quick: Value
        public internal(set) var standard: Value
        public internal(set) var slow: Value
    }
}

extension DS.Theme.SemanticTokens.Motion {
    public struct Value: Equatable, Sendable {
        let primitive: DS.Theme.DurationPrimitive

        init(_ primitive: DS.Theme.DurationPrimitive) {
            self.primitive = primitive
        }
    }
}
