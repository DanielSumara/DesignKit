import SwiftUI

extension DS {
    @MainActor
    @propertyWrapper
    @dynamicMemberLookup
    public struct BindableViewModel<ViewModel> {
        public var wrappedValue: ViewModel

        public init(wrappedValue: ViewModel) {
            self.wrappedValue = wrappedValue
        }

        public var projectedValue: BindableViewModel {
            self
        }

        public subscript<Value>(dynamicMember keyPath: ReferenceWritableKeyPath<ViewModel, Value>) -> Binding<Value> {
            let viewModel = wrappedValue
            return Binding {
                viewModel[keyPath: keyPath]
            } set: { value in
                viewModel[keyPath: keyPath] = value
            }
        }
    }
}
