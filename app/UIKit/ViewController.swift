import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(String(reflecting: self))::\(String(describing: self))#\(#function):L\(#line)")
    }
}
