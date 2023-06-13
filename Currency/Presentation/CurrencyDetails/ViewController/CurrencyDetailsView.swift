import UIKit

class CurrencyDetailsView: BaseView {
    lazy var contStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()

    lazy var historicalView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var otherCurrencyView: UIView = {
        let view = UIView()
        return view
    }()

    override func setupView() {
        super.setupView()
        addSubview(contStack)
        contStack.fillSuperview()
        contStack.addArrangedSubview(historicalView)
        contStack.addArrangedSubview(otherCurrencyView)
    }
}
