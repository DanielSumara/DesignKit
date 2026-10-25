extension DS.Theme {
    protocol Primitive: Sendable, Hashable {
        static var scale: String { get }
        static var all: [Self] { get }
        var name: String { get }
    }
}
