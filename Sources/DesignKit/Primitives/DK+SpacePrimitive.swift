extension DK {
    package struct SpacePrimitive: Primitive {
        package static let scale = "space"

        package let name: String
        package let points: Double

        package static let space2 = SpacePrimitive(name: "space2", points: 2)
        package static let space4 = SpacePrimitive(name: "space4", points: 4)
        package static let space8 = SpacePrimitive(name: "space8", points: 8)
        package static let space12 = SpacePrimitive(name: "space12", points: 12)
        package static let space16 = SpacePrimitive(name: "space16", points: 16)
        package static let space24 = SpacePrimitive(name: "space24", points: 24)
        package static let space32 = SpacePrimitive(name: "space32", points: 32)
        package static let space48 = SpacePrimitive(name: "space48", points: 48)

        package static let all: [SpacePrimitive] = [
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
