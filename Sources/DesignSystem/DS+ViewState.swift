import DesignKit
import SwiftUI

extension DS {
    public struct ViewState<Content, Loaded: View>: View {
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
                    ViewStateDelayedLoading(
                        label: loadingLabel ?? Text("designSystem.viewState.loading", bundle: .module),
                        placeholder: placeholder
                    )
                case .loaded(let value):
                    content?(value)
                case .edgeCase(let edgeCase):
                    EdgeCaseView(edgeCase)
                }
            }
        }

        private var isLoaded: Bool {
            if case .loaded = state { true } else { false }
        }

        private var placeholder: some View {
            Color.clear
                .frame(width: .zero, height: .zero)
                .accessibilityHidden(true)
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
                .padding(mds: \.large)
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
