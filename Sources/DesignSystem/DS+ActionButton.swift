import DesignKit
import SwiftUI

extension DS {
    public struct ActionButton: View {
        private let data: DK.ActionButton

        @Environment(\.actionButtonStyle) private var style
        @MDS private var mds
        @MDS(\.actionButton) private var configuration
        @State private var isRunningAction = false
        @State private var showsActivityIndicator = false

        public init(data: DK.ActionButton) {
            self.data = data
        }

        public var body: some View {
            Button(role: buttonRole, action: run) {
                ActionButtonLabel(
                    title: data.title,
                    look: look,
                    isPrimaryRole: data.role == .primary,
                    isLoading: showsActivityIndicator || data.state == .loading
                )
            }
            .modifier(ActionButtonLook(style: look, isPrimaryRole: data.role == .primary))
            .keyboardShortcut(shortcut)
            .disabled(data.state == .disabled)
            .accessibilityLabel(data.title)
        }

        private var look: Style {
            switch (data.role, style) {
            case (.destructive, .primary), (.destructive, .success): .destructive
            case (_, let style?): style
            case (.primary, nil): .primary
            case (.destructive, nil): .destructive
            case (.cancel, nil), (nil, nil): .secondary
            }
        }

        private var buttonRole: ButtonRole? {
            switch data.role {
            case .destructive: .destructive
            case .cancel: .cancel
            case .primary, nil: nil
            }
        }

        private var shortcut: KeyboardShortcut? {
            switch data.role {
            case .primary: .defaultAction
            case .cancel: .cancelAction
            case .destructive, nil: nil
            }
        }

        private func run() {
            guard !isRunningAction, data.state == .normal else { return }

            isRunningAction = true
            let delay = configuration.activityIndicatorDelay.duration
            let animation = mds(motion: \.quick)
            let action = data.action

            Task {
                let indicator = Task {
                    try await Task.sleep(for: delay)
                    withAnimation(animation) { showsActivityIndicator = true }
                }

                await action()

                indicator.cancel()
                isRunningAction = false
                withAnimation(animation) { showsActivityIndicator = false }
            }
        }
    }
}

private struct ActionButtonSamples: View {
    private static let actionSeconds = 3

    @MDS private var mds

    var body: some View {
        VStack(alignment: .leading, spacing: mds(spacing: \.medium)) {
            HStack(spacing: mds(spacing: \.small)) {
                button("Save", role: .primary)
                button("Delete", role: .destructive)
                button("Cancel", role: .cancel)
                button("Other", role: nil)
            }
            HStack(spacing: mds(spacing: \.small)) {
                button("Disabled", role: .primary, state: .disabled)
                button("Loading", role: .primary, state: .loading)
                button("Disabled", role: .cancel, state: .disabled)
                button("Loading", role: .cancel, state: .loading)
            }
            ForEach(DK.ActionButton.Role.allSamples, id: \.self) { role in
                HStack(spacing: mds(spacing: \.small)) {
                    ForEach(DS.ActionButton.Style.allCases, id: \.self) { style in
                        button(String(describing: style), role: role)
                            .actionButtonStyle(style)
                    }
                }
            }
        }
        .padding(mds: \.xxLarge)
    }

    private func button(
        _ title: String,
        role: DK.ActionButton.Role?,
        state: DK.ActionButton.State = .normal
    ) -> some View {
        DS.ActionButton(data: DK.ActionButton(title: title, role: role, state: state) {
            try? await Task.sleep(for: .seconds(Self.actionSeconds))
        })
    }
}

private extension DK.ActionButton.Role {
    static let allSamples: [DK.ActionButton.Role?] = [.primary, .destructive, .cancel, nil]
}

#Preview("Light") {
    ActionButtonSamples()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    ActionButtonSamples()
        .preferredColorScheme(.dark)
}
