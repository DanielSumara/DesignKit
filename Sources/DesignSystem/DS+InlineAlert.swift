import DesignKit
import SwiftUI

extension DS {
    public struct InlineAlert: View {
        @MDS(\.inlineAlert) private var configuration
        private let data: DK.InlineAlert

        public init(_ data: DK.InlineAlert) {
            self.data = data
        }

        public var body: some View {
            if let first = drawnNotices.first {
                HStack(alignment: .top, spacing: configuration.iconSpacing.points) {
                    icon(firstLineHasTitle: !first.title.isEmpty)
                    VStack(alignment: .leading, spacing: configuration.noticeSpacing.points) {
                        ForEach(drawnNotices.indices, id: \.self) { index in
                            NoticeText(notice: drawnNotices[index])
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(configuration.padding.points)
                .background(
                    configuration.background.color(data.status),
                    in: RoundedRectangle(cornerRadius: configuration.radius.points, style: .continuous)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: configuration.radius.points, style: .continuous)
                        .strokeBorder(configuration.border.color(data.status), lineWidth: configuration.borderWidth.points)
                }
                .accessibilityElement(children: .combine)
            }
        }

        private var drawnNotices: [DK.InlineAlert.Notice] {
            data.notices.filter { !$0.title.isEmpty || !$0.message.isEmpty }
        }

        private func icon(firstLineHasTitle: Bool) -> some View {
            Text(verbatim: " ")
                .font(mds: firstLineHasTitle ? \.semibold : \.regular, \.body)
                .hidden()
                .accessibilityHidden(true)
                .frame(width: configuration.iconSize.points)
                .overlay {
                    DS.StatusIcon(data.status, size: configuration.iconSize.points, label: statusWord)
                }
        }

        private var statusWord: Text {
            switch data.status {
            case .info: Text("designSystem.statusIcon.info", bundle: .module)
            case .success: Text("designSystem.statusIcon.success", bundle: .module)
            case .warning: Text("designSystem.statusIcon.warning", bundle: .module)
            case .error: Text("designSystem.statusIcon.error", bundle: .module)
            }
        }

        private struct NoticeText: View {
            @MDS(\.inlineAlert) private var configuration
            let notice: DK.InlineAlert.Notice

            var body: some View {
                VStack(alignment: .leading, spacing: configuration.titleSpacing.points) {
                    if !notice.title.isEmpty {
                        Text(notice.title)
                            .font(mds: \.semibold, \.body)
                            .foregroundStyle(mds: \.primary)
                    }
                    if !notice.message.isEmpty {
                        Text(notice.message)
                            .font(mds: \.regular, \.body)
                            .foregroundStyle(mds: \.secondary)
                    }
                }
            }
        }
    }
}

private struct InlineAlertVariants: View {
    @MDS private var mds

    var body: some View {
        VStack(spacing: mds(spacing: \.large)) {
            DS.InlineAlert(DK.InlineAlert(
                .init(status: .info, title: "Info", message: "Your statement was imported."),
                .init(status: .warning, title: "Warning", message: "One transaction has no category.")
            ))
            DS.InlineAlert(DK.InlineAlert(.init(status: .error, title: "Error", message: "The bank connection failed.")))
            DS.InlineAlert(DK.InlineAlert(.init(status: .success, title: "", message: "Message only.")))
            DS.InlineAlert(DK.InlineAlert(.init(status: .info, title: "Title only", message: "")))
        }
        .padding(mds: \.large)
    }
}

#Preview("Light") {
    InlineAlertVariants()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    InlineAlertVariants()
        .preferredColorScheme(.dark)
}
