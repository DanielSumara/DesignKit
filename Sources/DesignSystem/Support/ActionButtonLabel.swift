import SwiftUI

internal struct ActionButtonLabel: View {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.appearsActive) private var appearsActive
    let title: String
    let look: DS.ActionButton.Style
    let isPrimaryRole: Bool
    let isLoading: Bool

    var body: some View {
        ZStack {
            Text(title)
                .font(mds: \.semibold, \.body)
                .modifier(ActionButtonColorOverride(color: labelColor))
                .opacity(isLoading ? 0 : 1)

            if isLoading {
                DS.ActivityIndicator(label: Text(title))
                    .controlSize(.small)
                    .modifier(ActionButtonColorOverride(color: indicatorColor))
                    .resolvedTint(indicatorColor.map { color in { color.resolve(in: $0) } })
            }
        }
    }

    private var isProminent: Bool {
        switch look {
        case .primary, .success: true
        case .destructive: isPrimaryRole
        case .secondary, .tertiary: false
        }
    }

    private var labelColor: Color? {
        guard isEnabled else { return nil }

        switch look {
        case .destructive where isPrimaryRole:
            return appearsActive ? Color(mds: \.onBackground.critical) : nil
        case .primary:
            return appearsActive ? Color(mds: \.onBackground.brand) : nil
        case .success:
            return appearsActive ? Color(mds: \.onBackground.success) : nil
        case .tertiary:
            return Color(mds: \.foreground.brand)
        case .destructive:
            return Color(mds: \.foreground.critical)
        case .secondary:
            return nil
        }
    }

    private var indicatorColor: Color? {
        labelColor ?? (isProminent ? nil : .primary)
    }
}
