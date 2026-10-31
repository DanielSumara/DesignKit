import SwiftUI

internal struct ViewStateDelayedLoading<Placeholder: View>: View {
    @MDS(\.viewState) private var configuration
    @State private var showsLoadingLook = false
    let label: Text
    let placeholder: Placeholder

    var body: some View {
        Group {
            if showsLoadingLook {
                ViewStateLoadingLook(label: label)
            } else {
                placeholder
            }
        }
        .task {
            try? await Task.sleep(for: configuration.activityIndicatorDelay.duration)
            guard !Task.isCancelled else { return }
            var transaction = Transaction()
            transaction.disablesAnimations = true
            withTransaction(transaction) { showsLoadingLook = true }
        }
    }
}
