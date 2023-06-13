import UIKit

class OtherCurrencyDataCell: UITableViewCell {

    lazy var titleLabel = {
        let lbl = UILabel()
        return lbl
    }()

    public var cellModel : (String, Double)! {
        didSet {
            self.titleLabel.text = cellModel.0 + " -> " + String(format: "%.3f", cellModel.1)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupLayout()
    }

    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {
        addSubview(titleLabel)
        titleLabel.fillSuperview()
    }
}
