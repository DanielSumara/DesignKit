import SwiftUI

internal struct ViewStateLayout: Layout {
    let fillsSpace: Bool

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        guard fillsSpace else {
            return union(of: subviews.map { $0.sizeThatFits(proposal) })
        }
        let ideal = union(of: subviews.map { $0.sizeThatFits(.unspecified) })
        return CGSize(width: proposal.width ?? ideal.width, height: proposal.height ?? ideal.height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        for subview in subviews {
            subview.place(at: center, anchor: .center, proposal: ProposedViewSize(bounds.size))
        }
    }

    private func union(of sizes: [CGSize]) -> CGSize {
        CGSize(width: sizes.map(\.width).max() ?? 0, height: sizes.map(\.height).max() ?? 0)
    }
}
