import SwiftUI

internal struct ActionButtonLook: ViewModifier {
    let style: DS.ActionButton.Style
    let isPrimaryRole: Bool

    func body(content: Content) -> some View {
        switch style {
        case .destructive where isPrimaryRole:
            content
                .buttonStyle(.borderedProminent)
                .tint(mds: \.critical)
        case .primary:
            content
                .buttonStyle(.borderedProminent)
                .tint(mds: \.brand)
        case .success:
            content
                .buttonStyle(.borderedProminent)
                .tint(mds: \.success)
        case .secondary, .destructive:
            content
                .buttonStyle(.bordered)
                // Workaround: the scene tint would otherwise tint bordered buttons; removing it keeps the native neutral look.
                .tint(Color?.none)
        case .tertiary:
            content.buttonStyle(.borderless)
        }
    }
}
