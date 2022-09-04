import UIKit

extension UIViewController {
    func setContentViewController(_ viewController: UIViewController) {
        viewController.willMove(toParent: self)
        addChild(viewController)
        viewController.view.translatesAutoresizingMaskIntoConstraints = true
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
}
