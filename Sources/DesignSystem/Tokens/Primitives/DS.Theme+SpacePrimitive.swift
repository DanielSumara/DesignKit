extension DS.Theme {
    struct SpacePrimitive: Primitive {
        static let scale = "space"

        let name: String
        let points: Double

        static let space2 = SpacePrimitive(name: "space2", points: 2)
        static let space4 = SpacePrimitive(name: "space4", points: 4)
        static let space8 = SpacePrimitive(name: "space8", points: 8)
        static let space12 = SpacePrimitive(name: "space12", points: 12)
        static let space16 = SpacePrimitive(name: "space16", points: 16)
        static let space24 = SpacePrimitive(name: "space24", points: 24)
        static let space32 = SpacePrimitive(name: "space32", points: 32)
        static let space48 = SpacePrimitive(name: "space48", points: 48)

        static let all: [SpacePrimitive] = [
            .space2,
            .space4,
            .space8,
            .space12,
            .space16,
            .space24,
            .space32,
            .space48,
        ]
    }
}
