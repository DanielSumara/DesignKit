extension DK {
    package struct SizePrimitive: Primitive {
        package static let scale = "size"

        package let name: String
        package let points: Double

        package static let size12 = SizePrimitive(name: "size12", points: 12)
        package static let size16 = SizePrimitive(name: "size16", points: 16)
        package static let size20 = SizePrimitive(name: "size20", points: 20)
        package static let size24 = SizePrimitive(name: "size24", points: 24)

        package static let all: [SizePrimitive] = [
            .size12,
            .size16,
            .size20,
            .size24,
        ]
    }
}
