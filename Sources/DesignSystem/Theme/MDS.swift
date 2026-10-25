import SwiftUI

@propertyWrapper
public struct MDS<Value>: DynamicProperty {
    @Environment(\.theme) private var theme
    @Environment(\.textSize) private var textSize
    @Environment(\.accessibilityReduceMotion) private var reducesMotion
    @ScaledMetric(relativeTo: .body) private var bodyScale: CGFloat = 1
    private let value: KeyPath<DS.Theme.Reader, Value>

    public init(_ reader: KeyPath<DS.Theme.Reader, Value> = \.self) {
        value = reader
    }

    public init(_ component: KeyPath<DS.Theme.Components, Value>) {
        value = (\DS.Theme.Reader.components).appending(path: component)
    }

    public var wrappedValue: Value {
        DS.Theme.Reader(theme: theme, textSize: textSize, bodyScale: bodyScale, reducesMotion: reducesMotion)[keyPath: value]
    }
}
