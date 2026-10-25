extension DS.Theme {
    struct DurationPrimitive: Primitive {
        static let scale = "duration"

        let name: String
        let milliseconds: Int

        static let duration150 = DurationPrimitive(name: "duration150", milliseconds: 150)
        static let duration250 = DurationPrimitive(name: "duration250", milliseconds: 250)
        static let duration400 = DurationPrimitive(name: "duration400", milliseconds: 400)

        static let all: [DurationPrimitive] = [
            .duration150,
            .duration250,
            .duration400,
        ]

        var seconds: Double {
            Double(milliseconds) / 1000
        }
    }
}
