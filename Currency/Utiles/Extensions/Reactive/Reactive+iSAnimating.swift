import UIKit
import RxCocoa
import RxSwift

extension Reactive where Base: UIViewController {

        internal var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vCont, active) in
            if active {
                vCont.startAnimating()
            } else {
                vCont.stopAnimating()
            }
        })
    }

}
