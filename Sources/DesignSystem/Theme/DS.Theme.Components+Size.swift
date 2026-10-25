import Foundation

extension DS.Theme.Components {
    public struct Size: Equatable, Sendable {
        let primitive: DS.Theme.SizePrimitive
        var factor: CGFloat = 1

        init(_ primitive: DS.Theme.SizePrimitive) {
            self.primitive = primitive
        }

        public var points: CGFloat {
            CGFloat(primitive.points) * factor
        }
    }
}
