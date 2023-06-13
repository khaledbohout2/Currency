//
//  HistoricalDataCell.swift
//  Currency
//
//  Created by Khaled Bohout on 13/06/2023.
//

import UIKit

class HistoricalDataCell: UITableViewCell {

    lazy var dateLabel = {
        let lbl = UILabel()
        return lbl
    }()

    lazy var valueLabel = {
        let lbl = UILabel()
        return lbl
    }()

    public var cellModel : HistoricalRates! {
        didSet {
            dateLabel.text = "On" + " " + (cellModel.date ?? "")
            let key = "1" + " " + (cellModel.base ?? "")
            let fromCurrency = (cellModel.rates?[cellModel.toCurrency ?? ""] ?? 0.0)
            let value = String(format: "%.3f", fromCurrency) + " " + (cellModel.toCurrency ?? "")
            valueLabel.text = key + " -> " + value
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
        addSubview(dateLabel)
        dateLabel.anchor(.top(topAnchor, constant: 5),
                         .leading(leadingAnchor, constant: 5))

        addSubview(valueLabel)
        valueLabel.anchor(.top(dateLabel.bottomAnchor, constant: 5),
                          .leading(leadingAnchor, constant: 5),
                          .bottom(bottomAnchor, constant: 10))
    }
}
