import UIKit

extension UIViewController {
    public func add(asChildViewController viewController: UIViewController,to parentView:UIView) {
        addChild(viewController)
        parentView.addSubview(viewController.view)
        viewController.view.frame = parentView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
}
