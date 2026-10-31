import SwiftUI

internal struct FieldRowLayout: Layout {
    let labelWidth: CGFloat
    let spacing: CGFloat

    private struct Metrics {
        let column: CGFloat
        let label: CGSize
        let control: CGSize
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        guard subviews.count == 2 else { return .zero }
        let metrics = metrics(width: proposal.width, subviews: subviews)
        return CGSize(
            width: proposal.width ?? metrics.column + spacing + metrics.control.width,
            height: max(metrics.label.height, metrics.control.height)
        )
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        guard subviews.count == 2 else { return }
        let metrics = metrics(width: bounds.width, subviews: subviews)
        let labelBaseline = subviews[0].dimensions(in: ProposedViewSize(metrics.label))[.firstTextBaseline]
        let controlBaseline = subviews[1].dimensions(in: ProposedViewSize(metrics.control))[.firstTextBaseline]
        let baseline = max(labelBaseline, controlBaseline)
        subviews[0].place(
            at: CGPoint(x: bounds.minX, y: bounds.minY + baseline - labelBaseline),
            anchor: .topLeading,
            proposal: ProposedViewSize(metrics.label)
        )
        subviews[1].place(
            at: CGPoint(x: bounds.minX + metrics.column + spacing, y: bounds.minY + baseline - controlBaseline),
            anchor: .topLeading,
            proposal: ProposedViewSize(metrics.control)
        )
    }

    private func metrics(width: CGFloat?, subviews: Subviews) -> Metrics {
        let ideal = subviews[0].sizeThatFits(.unspecified).width
        var column = max(labelWidth, ideal)
        if let width {
            column = min(column, width / 2)
        }
        let label = subviews[0].sizeThatFits(ProposedViewSize(width: column, height: nil))
        let controlWidth = width.map { max($0 - column - spacing, 0) }
        let control = subviews[1].sizeThatFits(ProposedViewSize(width: controlWidth, height: nil))
        return Metrics(column: column, label: label, control: control)
    }
}
