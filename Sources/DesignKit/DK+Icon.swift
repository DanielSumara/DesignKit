import Foundation

extension DK {
    public enum Icon: Equatable, Sendable {
        case symbol(String)
        case image(Data)
        case monogram(String, DK.AccentTint)
    }
}
