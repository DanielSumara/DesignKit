import SwiftUI

internal struct FormFocusContext {
    let focused: FocusState<FieldID?>.Binding
    let order: [FieldID]
    let registry: FormFocusRegistry
    let scrollTo: @MainActor (FieldID) -> Void

    func isFocused(_ id: FieldID) -> Bool {
        focused.wrappedValue == id
    }

    func isLast(_ id: FieldID) -> Bool {
        order.last == id
    }

    @MainActor
    func submit(from id: FieldID) {
        guard let index = order.firstIndex(of: id) else { return }
        if order.indices.contains(index + 1) {
            let next = order[index + 1]
            scrollTo(next)
            Task { @MainActor in
                focused.wrappedValue = next
            }
        } else {
            #if !os(macOS)
            focused.wrappedValue = nil
            #endif
        }
    }
}
