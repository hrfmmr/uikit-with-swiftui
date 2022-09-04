import Foundation

public enum Loadable<T> {
    case notRequested
    case isLoading
    case loaded(T)
    case failed(Error)
}

extension Loadable: Equatable where T: Equatable {
    public static func == (lhs: Loadable<T>, rhs: Loadable<T>) -> Bool {
        switch (lhs, rhs) {
        case (.notRequested, .notRequested):
            return true
        case (.isLoading, .isLoading):
            return true
        case let (.loaded(l), .loaded(r)):
            return l == r
        case let (.failed(l), .failed(r)):
            return l.localizedDescription == r.localizedDescription
        default:
            return false
        }
    }
}
