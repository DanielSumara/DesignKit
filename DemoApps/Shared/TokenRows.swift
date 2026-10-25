import DesignSystem
import SwiftUI

internal struct TokenRows<Element, Trailing: View>: View {
    @MDS private var mds
    let detailTitle: String
    let elements: [Element]
    let name: KeyPath<Element, String>
    let detail: (Element) -> String
    @ViewBuilder let trailing: (Element) -> Trailing

    var body: some View {
        CompactSwitch {
            stack
        } regular: {
            table
        }
    }

    private var table: some View {
        Grid(alignment: .leading, horizontalSpacing: mds(spacing: \.large), verticalSpacing: mds(spacing: \.small)) {
            GridRow {
                Text("Token")
                Text(detailTitle)
            }
            .font(mds: \.caption)
            .foregroundStyle(mds: \.secondary)
            ForEach(elements, id: name) { element in
                GridRow {
                    Text(element[keyPath: name])
                    Text(detail(element))
                        .foregroundStyle(mds: \.secondary)
                    trailing(element)
                }
                .font(mds: \.body)
            }
        }
    }

    private var stack: some View {
        VStack(alignment: .leading, spacing: mds(spacing: \.medium)) {
            ForEach(elements, id: name) { element in
                VStack(alignment: .leading, spacing: mds(spacing: \.xxSmall)) {
                    Text(element[keyPath: name])
                        .font(mds: \.body)
                    Text(detail(element))
                        .font(mds: \.caption)
                        .foregroundStyle(mds: \.secondary)
                    trailing(element)
                }
                .accessibilityElement(children: .contain)
            }
        }
    }
}

extension TokenRows where Trailing == EmptyView {
    init(detailTitle: String, elements: [Element], name: KeyPath<Element, String>, detail: @escaping (Element) -> String) {
        self.init(detailTitle: detailTitle, elements: elements, name: name, detail: detail) { _ in EmptyView() }
    }
}
