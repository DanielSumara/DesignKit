import SwiftUI

extension EnvironmentValues {
    @Entry var formFocus: FormFocusContext?
    @Entry var fieldID: FieldID?
    @Entry var fieldLabelWidth: CGFloat = 0
    @Entry var fieldIsFocused: Bool = false
}
