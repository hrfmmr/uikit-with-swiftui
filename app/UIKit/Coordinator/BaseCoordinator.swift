import Foundation

open class BaseCoordinator: NSObject {
    private weak var parent: BaseCoordinator?
    private var children: [BaseCoordinator] = []

    deinit {
        print("🗑DEINIT:\(name)")
    }

    func coordinate(to coordinator: BaseCoordinator) {
        coordinator.parent = self
        children.append(coordinator)
        coordinator.start()
    }

    func start() {
        print("💨\(name) Did start")
    }

    func finish() {
        parent?.remove(coordinator: self)
        print("👋\(name) Did finish")
    }

    func remove(coordinator: BaseCoordinator) {
        if let index = children.firstIndex(where: { $0 === coordinator }) {
            children.remove(at: index)
        }
        coordinator.parent = nil
    }

    private var name: String {
        .init(describing: type(of: self))
    }
}
