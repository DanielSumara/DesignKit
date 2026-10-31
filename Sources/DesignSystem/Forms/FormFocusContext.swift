import SwiftUI

internal struct FormFocusContext {
    let focused: FocusState<FieldID?>.Binding
    let order: [FieldID]

    func isFocused(_ id: FieldID) -> Bool {
        focused.wrappedValue == id
    }

    func isLast(_ id: FieldID) -> Bool {
        order.last == id
    }

    func submit(from id: FieldID) {
        guard let index = order.firstIndex(of: id) else { return }
        if order.indices.contains(index + 1) {
            focused.wrappedValue = order[index + 1]
        } else {
            #if !os(macOS)
            focused.wrappedValue = nil
            #endif
        }
    }
}
