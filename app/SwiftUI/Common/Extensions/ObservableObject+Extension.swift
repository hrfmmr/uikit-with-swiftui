import SwiftUI

typealias LoadableSubject<Value> = Binding<Loadable<Value>>

extension ObservableObject {
    func loadableSubject<Value>(_ keyPath: WritableKeyPath<Self, Loadable<Value>>) -> LoadableSubject<Value> {
        let defaultValue = self[keyPath: keyPath]
        return .init { [weak self] in
            self?[keyPath: keyPath] ?? defaultValue
        } set: { [weak self] value in
            DispatchQueue.main.async {
                self?[keyPath: keyPath] = value
            }
        }
    }
}
