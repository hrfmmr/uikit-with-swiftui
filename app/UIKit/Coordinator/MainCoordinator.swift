import Foundation
import UIKit

open class MainCoordinator: BaseCoordinator {
    let navigator: UINavigationController

    init(navigator: UINavigationController) {
        self.navigator = navigator
        super.init()
        navigator.delegate = self
    }
}

protocol HasCoordinator {
    var coordinator: BaseCoordinator? { get set }
}

extension MainCoordinator: UINavigationControllerDelegate {
    public func navigationController(
        _ navigationController: UINavigationController,
        didShow _: UIViewController,
        animated _: Bool
    ) {
        guard
            let fromVC = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(fromVC)
        else { return }

        switch fromVC {
        case let vc as HasCoordinator:
            vc.coordinator?.finish()
        default:
            break
        }
    }
}
