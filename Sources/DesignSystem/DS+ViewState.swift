import DesignKit
import SwiftUI

extension DS {
    public struct ViewState<Content, Loaded: View>: View {
        @MDS(\.viewState) private var configuration
        @State private var showsLoadingLook = false
        private let state: DK.ViewState<Content>
        private let loadingLabel: Text?
        private let content: ((Content) -> Loaded)?

        public init(
            _ state: DK.ViewState<Content>,
            loadingLabel: Text? = nil,
            @ViewBuilder content: @escaping (Content) -> Loaded
        ) {
            self.state = state
            self.loadingLabel = loadingLabel
            self.content = content
        }

        public var body: some View {
            ViewStateLayout(fillsSpace: !isLoaded) {
                switch state {
                case .idle:
                    placeholder
                case .loading:
                    if showsLoadingLook {
                        ViewStateLoadingLook(label: loadingLabel ?? Text("designSystem.viewState.loading", bundle: .module))
                    } else {
                        placeholder
                    }
                case .loaded(let value):
                    content?(value)
                case .edgeCase(let edgeCase):
                    EdgeCaseView(edgeCase)
                }
            }
            .task(id: isLoading) {
                await updateLoadingLook()
            }
        }

        private var isLoading: Bool {
            if case .loading = state { true } else { false }
        }

        private var isLoaded: Bool {
            if case .loaded = state { true } else { false }
        }

        private var placeholder: some View {
            Color.clear
                .frame(width: .zero, height: .zero)
                .accessibilityHidden(true)
        }

        private func updateLoadingLook() async {
            guard isLoading else {
                setShowsLoadingLook(false)
                return
            }
            try? await Task.sleep(for: configuration.activityIndicatorDelay.duration)
            guard !Task.isCancelled else { return }
            setShowsLoadingLook(true)
        }

        private func setShowsLoadingLook(_ value: Bool) {
            var transaction = Transaction()
            transaction.disablesAnimations = true
            withTransaction(transaction) { showsLoadingLook = value }
        }
    }
}

extension DS.ViewState where Content == Never, Loaded == Never {
    public init(_ state: DK.ViewState<Never>, loadingLabel: Text? = nil) {
        self.state = state
        self.loadingLabel = loadingLabel
        self.content = nil
    }
}

private struct ViewStateCases: View {
    private static let sampleHeight: CGFloat = 200

    @MDS private var mds

    private let edgeCase = DK.EdgeCase(
        icon: .symbol("exclamationmark.triangle"),
        title: "Error while reading data",
        message: "Try again later.",
        actions: [DK.ActionButton(title: "Try again", role: .primary) {}]
    )

    var body: some View {
        VStack(spacing: mds(spacing: \.large)) {
            sample("Idle") {
                DS.ViewState(DK.ViewState<String>.idle) { Text($0) }
            }
            sample("Loading") {
                DS.ViewState(DK.ViewState<String>.loading) { Text($0) }
            }
            sample("Loaded") {
                DS.ViewState(DK.ViewState<String>.loaded("Loaded content")) { Text($0) }
            }
            sample("Edge case") {
                DS.ViewState(DK.ViewState<String>.edgeCase(edgeCase)) { Text($0) }
            }
            sample("Content-less loading") {
                DS.ViewState(DK.ViewState<Never>.loading)
            }
        }
        .padding(mds: \.large)
    }

    private func sample(_ title: String, @ViewBuilder _ view: () -> some View) -> some View {
        VStack(spacing: mds(spacing: \.small)) {
            Text(verbatim: title)
                .font(mds: \.caption)
                .foregroundStyle(mds: \.tertiary)
            view()
                .frame(height: Self.sampleHeight)
                .border(mds: \.subtle, width: \.thin, cornerRadius: \.small)
        }
    }
}

#Preview("Light") {
    ScrollView {
        ViewStateCases()
    }
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    ScrollView {
        ViewStateCases()
    }
    .preferredColorScheme(.dark)
}
