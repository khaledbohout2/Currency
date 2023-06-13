import UIKit
import RxSwift
import RxCocoa

class CurrencyDetailsVC: BaseVC<CurrencyDetailsView> {

    private let viewModel: CurrencyDetailsViewModel
    let disposeBag = DisposeBag()

    private lazy var dataViewForOtherCurrencyData: CurrencyDataTableViewController = {
        let vCont = CurrencyDataTableViewController(informationType: .otherCurrencyData)
        self.add(asChildViewController: vCont, to: mainView.otherCurrencyView)
        return vCont
    }()

    private lazy var dataViewForHistoricalCurrencyData: CurrencyDataTableViewController = {
        let vCont = CurrencyDataTableViewController(informationType: .historicalData)
        self.add(asChildViewController: vCont, to: mainView.historicalView)
        return vCont
    }()

    init(viewModel: CurrencyDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.getHistoricalRates()
        viewModel.getPopularConventions()
    }

    private func setupBindings() {

        viewModel.loading
            .bind(to: self.rx.isAnimating).disposed(by: disposeBag)

        viewModel
            .popularCurrencies
            .observe(on: MainScheduler.instance)
            .bind(to: dataViewForOtherCurrencyData.currencyData)
            .disposed(by: disposeBag)

        viewModel
            .historicalDataModel
            .observe(on: MainScheduler.instance)
            .bind(to: dataViewForHistoricalCurrencyData.historicalData)
            .disposed(by: disposeBag)

        viewModel.error.observe(on: MainScheduler.instance)
            .subscribe(onNext: { [ weak self ]error in
                guard let self = self else { return }
                self.parseNetworkError(error: error)

            }).disposed(by: disposeBag)

    }
}
