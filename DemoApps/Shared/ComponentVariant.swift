import SwiftUI

internal struct ComponentVariant: Identifiable {
    let name: String
    let view: @MainActor () -> AnyView

    var id: String { name }

    init<Content: View>(name: String, @ViewBuilder view: @escaping @MainActor () -> Content) {
        self.name = name
        self.view = { AnyView(view()) }
    }
}
