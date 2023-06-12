import UIKit
import RxCocoa
import RxSwift

protocol ProgressLoadingViewable {
    func startAnimating()
    func stopAnimating()
}

extension UIViewController: ProgressLoadingViewable {}

extension ProgressLoadingViewable where Self : UIViewController {
    func startAnimating(){
        let animateLoading = LoadingView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        view.addSubview(animateLoading)
        view.bringSubviewToFront(animateLoading)
        animateLoading.restorationIdentifier = "loadingView"
        animateLoading.center = view.center

        animateLoading.clipsToBounds = true
        animateLoading.show()
    }

    func stopAnimating() {
        for item in view.subviews
            where item.restorationIdentifier == "loadingView" {
                UIView.animate(withDuration: 0.3, animations: {
                    item.alpha = 0
                }) { (_) in
                    item.removeFromSuperview()
                }
        }
    }
}
