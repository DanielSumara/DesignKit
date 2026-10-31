import DesignKit
import SwiftUI

extension DS {
    public struct ModalSheet<Content: View>: View {
        public typealias Width = ModalSheetWidth

        private let data: DK.ModalSheet
        private let width: Width
        private let content: Content

        @MDS private var mds
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
                HStack(spacing: mds(spacing: \.small)) {
                    Spacer(minLength: 0)
                    cancelButton
                    confirmButton
                }
                .padding([.bottom, .leading, .trailing], configuration.padding.points)
                .padding(.top, configuration.contentSpacing.points)
            }
            .frame(width: sheetWidth, alignment: .top)
            .frame(maxHeight: configuration.maxHeight.points)
            .presentationSizing(.fitted)
            .interactiveDismissDisabled(ignoresCancelPath)
            #else
            sized(NavigationStack {
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
            })
            .interactiveDismissDisabled(data.confirmsDiscard || ignoresCancelPath)
            #endif
        }

        #if !os(macOS)
        @ViewBuilder private func sized(_ view: some View) -> some View {
            switch width {
            case .standard: view.presentationSizing(.form)
            case .wide: view.presentationSizing(.page)
            }
        }
        #endif

        #if os(macOS)
        private var sheetWidth: CGFloat {
            switch width {
            case .standard: configuration.standardWidth.points
            case .wide: configuration.wideWidth.points
            }
        }
        #endif

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
                await takeCancelPath()
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

        private func takeCancelPath() async {
            guard !ignoresCancelPath else { return }

            if data.confirmsDiscard {
                showsDiscardConfirmation = true
            } else {
                await data.cancel.action()
            }
        }

        private func run(_ action: @escaping @MainActor () async -> Void) {
            Task { await action() }
        }
    }
}

private struct ModalSheetSamples: View {
    private struct Sample: Identifiable {
        let id: String
        let data: DK.ModalSheet
    }

    @MDS(\.modalSheet) private var configuration

    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            VStack(alignment: .leading, spacing: configuration.padding.points) {
                ForEach(samples) { sample in
                    DS.ModalSheet(sample.data) {
                        Text("Content")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .frame(width: configuration.standardWidth.points, height: configuration.maxHeight.points)
                    .border(mds: \.subtle, width: \.thin, cornerRadius: \.small)
                }
            }
            .padding(configuration.padding.points)
        }
    }

    private var samples: [Sample] {
        [
            Sample(id: "title", data: sheet()),
            Sample(id: "subtitle", data: sheet(subtitle: "Subtitle")),
            Sample(id: "confirm", data: sheet(confirm: confirm)),
            Sample(id: "subtitleConfirm", data: sheet(subtitle: "Subtitle", confirm: confirm)),
            Sample(id: "discard", data: sheet(subtitle: "Subtitle", confirm: confirm, confirmsDiscard: true))
        ]
    }

    private var confirm: DK.ActionButton {
        DK.ActionButton(title: "Save") {}
    }

    private func sheet(
        subtitle: String? = nil,
        confirm: DK.ActionButton? = nil,
        confirmsDiscard: Bool = false
    ) -> DK.ModalSheet {
        DK.ModalSheet(
            title: "Title",
            subtitle: subtitle,
            cancel: DK.ActionButton(title: "Cancel") {},
            confirm: confirm,
            confirmsDiscard: confirmsDiscard
        )
    }
}

#Preview("Light") {
    ModalSheetSamples()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    ModalSheetSamples()
        .preferredColorScheme(.dark)
}
