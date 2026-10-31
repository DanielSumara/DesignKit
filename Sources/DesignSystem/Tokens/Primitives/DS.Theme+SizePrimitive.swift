extension DS.Theme {
    struct SizePrimitive: Primitive {
        static let scale = "size"

        let name: String
        let points: Double

        static let size12 = SizePrimitive(name: "size12", points: 12)
        static let size16 = SizePrimitive(name: "size16", points: 16)
        static let size20 = SizePrimitive(name: "size20", points: 20)
        static let size24 = SizePrimitive(name: "size24", points: 24)
        static let size48 = SizePrimitive(name: "size48", points: 48)
        static let size64 = SizePrimitive(name: "size64", points: 64)
        static let size480 = SizePrimitive(name: "size480", points: 480)
        static let size560 = SizePrimitive(name: "size560", points: 560)
        static let size640 = SizePrimitive(name: "size640", points: 640)

        static let all: [SizePrimitive] = [
            .size12,
            .size16,
            .size20,
            .size24,
            .size48,
            .size64,
            .size480,
            .size560,
            .size640,
        ]
    }
}
