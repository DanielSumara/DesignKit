import DesignKit

internal enum StatusOption {
    static let all: [(name: String, status: DK.Status)] = [
        ("info", .info),
        ("success", .success),
        ("warning", .warning),
        ("error", .error)
    ]
}
