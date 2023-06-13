import UIKit
import RxSwift
import RxCocoa

enum InformationType {
    case historicalData
    case otherCurrencyData
}

class CurrencyDataTableViewController: BaseVC<TableView>{

    public var currencyData = PublishSubject<[String: Double]>()
    public var historicalData = PublishSubject<[HistoricalRates]>()
    public var informationType: InformationType = .historicalData

    private let disposeBag = DisposeBag()

    init(informationType: InformationType) {
        self.informationType = informationType
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }

    private func setupBinding(){
        switch informationType {
        case .historicalData:
            mainView.tableView.register(HistoricalDataCell.self, forCellReuseIdentifier: HistoricalDataCell.identifier)

            historicalData.bind(to: mainView.tableView.rx.items(cellIdentifier: HistoricalDataCell.identifier, cellType: HistoricalDataCell.self)) {  (row,track,cell) in
                cell.cellModel = track
                }.disposed(by: disposeBag)

        case .otherCurrencyData:
            mainView.tableView.register(OtherCurrencyDataCell.self, forCellReuseIdentifier: OtherCurrencyDataCell.identifier)

            currencyData.bind(to: mainView.tableView.rx.items(cellIdentifier: OtherCurrencyDataCell.identifier, cellType: OtherCurrencyDataCell.self)) {  (row,track,cell) in
                cell.cellModel = track
                }.disposed(by: disposeBag)
        }

    }
}

