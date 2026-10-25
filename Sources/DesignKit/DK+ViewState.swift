extension DK {
    public enum ViewState<Content> {
        case idle
        case loading
        case loaded(Content)
        case edgeCase(DK.EdgeCase)
    }
}

extension DK.ViewState: Equatable where Content: Equatable {}
extension DK.ViewState: Sendable where Content: Sendable {}
