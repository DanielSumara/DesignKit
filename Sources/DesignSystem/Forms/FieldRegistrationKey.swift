import SwiftUI

internal struct FieldRegistrationKey: PreferenceKey {
    static let defaultValue: [FieldRegistration] = []

    static func reduce(value: inout [FieldRegistration], nextValue: () -> [FieldRegistration]) {
        value.append(contentsOf: nextValue())
    }
}
