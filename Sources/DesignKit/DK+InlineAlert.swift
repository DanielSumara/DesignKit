extension DK {
    public struct InlineAlert: Equatable, Sendable {
        public let notices: [Notice]
        public let status: DK.Status

        public init?(notices: [Notice]) {
            guard let status = notices.map(\.status).max() else { return nil }
            self.notices = notices
            self.status = status
        }

        public init(_ notice: Notice, _ others: Notice...) {
            let notices = [notice] + others
            self.notices = notices
            status = notices.map(\.status).max() ?? notice.status
        }
    }
}

extension DK.InlineAlert {
    public struct Notice: Equatable, Sendable {
        public let status: DK.Status
        public let title: String
        public let message: String

        public init(status: DK.Status = .info, title: String, message: String) {
            self.status = status
            self.title = title
            self.message = message
        }
    }
}
