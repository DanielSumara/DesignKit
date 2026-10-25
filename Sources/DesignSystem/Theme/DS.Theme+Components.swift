extension DS.Theme {
    public struct Components: Equatable, Sendable {
        public internal(set) var activityIndicator: ActivityIndicator
        public internal(set) var actionButton: ActionButton
        public internal(set) var statusIcon: StatusIcon
        public internal(set) var inlineAlert: InlineAlert
        public internal(set) var edgeCase: EdgeCase
    }
}
