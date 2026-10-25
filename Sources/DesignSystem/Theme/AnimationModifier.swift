import SwiftUI

internal struct AnimationModifier<Value: Equatable>: ViewModifier {
    @MDS private var mds
    let motion: KeyPath<DS.Theme.SemanticTokens.Motion, DS.Theme.SemanticTokens.Motion.Value>
    let value: Value

    func body(content: Content) -> some View {
        content.animation(mds(motion: motion), value: value)
    }
}
