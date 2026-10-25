extension DS.Theme {
    struct SizePrimitive: Primitive {
        static let scale = "size"

        let name: String
        let points: Double

        static let size12 = SizePrimitive(name: "size12", points: 12)
        static let size16 = SizePrimitive(name: "size16", points: 16)
        static let size20 = SizePrimitive(name: "size20", points: 20)
        static let size24 = SizePrimitive(name: "size24", points: 24)

        static let all: [SizePrimitive] = [
            .size12,
            .size16,
            .size20,
            .size24,
        ]
    }
}
