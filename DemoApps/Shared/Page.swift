import SwiftUI

internal protocol Page {
    associatedtype Content: View

    var id: String { get }
    var title: String { get }
    var section: Section { get }

    @ViewBuilder @MainActor var content: Content { get }
}
