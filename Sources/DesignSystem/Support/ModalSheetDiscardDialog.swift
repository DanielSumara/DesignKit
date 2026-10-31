import SwiftUI

internal struct ModalSheetDiscardDialog: ViewModifier {
    @Binding var isPresented: Bool
    let onDiscard: () -> Void

    func body(content: Content) -> some View {
        content
            .confirmationDialog(
                Text("designSystem.modalSheet.discardTitle", bundle: .module),
                isPresented: $isPresented,
                titleVisibility: .visible
            ) {
                Button(role: .destructive, action: onDiscard) {
                    Text("designSystem.modalSheet.discardChanges", bundle: .module)
                }
                Button(role: .cancel) {} label: {
                    Text("designSystem.modalSheet.keepEditing", bundle: .module)
                }
            } message: {
                Text("designSystem.modalSheet.discardMessage", bundle: .module)
            }
    }
}

extension View {
    func modalSheetDiscardDialog(isPresented: Binding<Bool>, onDiscard: @escaping () -> Void) -> some View {
        modifier(ModalSheetDiscardDialog(isPresented: isPresented, onDiscard: onDiscard))
    }
}
