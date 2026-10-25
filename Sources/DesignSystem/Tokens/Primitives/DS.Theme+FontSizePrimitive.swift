extension DS.Theme {
    struct FontSizePrimitive: Primitive {
        static let scale = "fontSize"

        let name: String
        let points: Double

        static let fontSize10 = FontSizePrimitive(name: "fontSize10", points: 10)
        static let fontSize11 = FontSizePrimitive(name: "fontSize11", points: 11)
        static let fontSize12 = FontSizePrimitive(name: "fontSize12", points: 12)
        static let fontSize13 = FontSizePrimitive(name: "fontSize13", points: 13)
        static let fontSize15 = FontSizePrimitive(name: "fontSize15", points: 15)
        static let fontSize17 = FontSizePrimitive(name: "fontSize17", points: 17)
        static let fontSize22 = FontSizePrimitive(name: "fontSize22", points: 22)
        static let fontSize26 = FontSizePrimitive(name: "fontSize26", points: 26)

        static let all: [FontSizePrimitive] = [
            .fontSize10,
            .fontSize11,
            .fontSize12,
            .fontSize13,
            .fontSize15,
            .fontSize17,
            .fontSize22,
            .fontSize26,
        ]
    }
}
