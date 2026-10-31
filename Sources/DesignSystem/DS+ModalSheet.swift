import DesignKit
import SwiftUI

extension DS {
    public struct ModalSheet<Content: View>: View {
        public typealias Width = ModalSheetWidth

        private let data: DK.ModalSheet
        private let width: Width
        private let content: Content

        @MDS(\.modalSheet) private var configuration
        @State private var isConfirming = false
        @State private var showsDiscardConfirmation = false

        public init(_ data: DK.ModalSheet, width: Width = .standard, @ViewBuilder content: () -> Content) {
            self.data = data
            self.width = width
            self.content = content()
        }

        public var body: some View {
            #if os(macOS)
            VStack(spacing: .zero) {
                ModalSheetHeader(title: data.title, subtitle: data.subtitle)
                    .padding([.top, .leading, .trailing], configuration.padding.points)
                    .padding(.bottom, configuration.contentSpacing.points)
                content
                    .disabled(isBusy)
                HStack(spacing: configuration.contentSpacing.points) {
                    Spacer(minLength: 0)
                    cancelButton
                    confirmButton
                }
                .padding([.bottom, .leading, .trailing], configuration.padding.points)
                .padding(.top, configuration.contentSpacing.points)
            }
            #else
            NavigationStack {
                content
                    .disabled(isBusy)
                    .navigationTitle(data.title)
                    .navigationSubtitle(data.subtitle ?? "")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) { cancelButton }
                        if data.confirm != nil {
                            ToolbarItem(placement: .confirmationAction) { confirmButton }
                        }
                    }
            }
            .interactiveDismissDisabled(data.confirmsDiscard || ignoresCancelPath)
            #endif
        }

        private var isBusy: Bool {
            isConfirming || data.confirm?.state == .loading
        }

        private var ignoresCancelPath: Bool {
            isBusy || data.cancel.state == .disabled
        }

        private var cancelButton: some View {
            DS.ActionButton(data: DK.ActionButton(
                id: data.cancel.id,
                title: data.cancel.title,
                role: .cancel,
                state: isBusy ? .disabled : data.cancel.state
            ) {
                takeCancelPath()
            })
            .modalSheetDiscardDialog(isPresented: $showsDiscardConfirmation) {
                run(data.cancel.action)
            }
        }

        @ViewBuilder private var confirmButton: some View {
            if let confirm = data.confirm {
                let action = confirm.action
                DS.ActionButton(data: DK.ActionButton(
                    id: confirm.id,
                    title: confirm.title,
                    role: .primary,
                    state: confirm.state
                ) {
                    isConfirming = true
                    await action()
                    isConfirming = false
                })
            }
        }

        private func takeCancelPath() {
            guard !ignoresCancelPath else { return }

            if data.confirmsDiscard {
                showsDiscardConfirmation = true
            } else {
                run(data.cancel.action)
            }
        }

        private func run(_ action: @escaping @MainActor () async -> Void) {
            Task { await action() }
        }
    }
}
