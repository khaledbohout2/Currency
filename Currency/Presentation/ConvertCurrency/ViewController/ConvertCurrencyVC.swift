import UIKit
import RxSwift
import RxCocoa

class ConvertCurrencyVC: BaseVC<ConvertCurrencyView> {
    
    private let viewModel: ConvertCurrencyViewModel
    let disposeBag = DisposeBag()

    init(viewModel: ConvertCurrencyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModelBindings()
        self.viewModel.getValidCurrencySymbols()
    }

    func setupViewModelBindings() {

        viewModel.loading
            .bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        viewModel.currencySymbols
        .observe(on: MainScheduler.instance)
        .bind(to: mainView.fromTextField.pickerItems)
        .disposed(by: disposeBag)

        viewModel.currencySymbols.observe(on: MainScheduler.instance)
            .bind(to: mainView.toTextField.pickerItems)
            .disposed(by: disposeBag)

        viewModel.convertedValue.observe(on: MainScheduler.instance)
            .bind(to: mainView.convertedValueTextField.rx.text)
            .disposed(by: disposeBag)

        viewModel.convertedValue.observe(on: MainScheduler.instance)
            .subscribe(onNext: { [ weak self ] value in
                guard let self = self else { return }
                self.mainView.detailsBtn.isEnabled = true
            })
            .disposed(by: disposeBag)

        viewModel.currencySymbols.observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
            self.callCurrencyConversionAPI()
            }).disposed(by: disposeBag)
        mainView.inputValueTextField.rx.controlEvent([.editingDidEnd])
            .asObservable()
            .subscribe(onNext:{ [weak self] in
                guard let self = self else { return }
                self.callCurrencyConversionAPI()
            }).disposed(by: disposeBag)

        viewModel.error.observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self ] error in
                guard let self = self else { return }

            }).disposed(by: disposeBag)

        mainView.fromTextField.rx.controlEvent([.editingDidEnd])
            .asObservable()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.callCurrencyConversionAPI()
            }).disposed(by: disposeBag)

        mainView.toTextField.rx.controlEvent([.editingDidEnd])
            .asObservable()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.callCurrencyConversionAPI()
            }).disposed(by: disposeBag)

        let _ = mainView.swapBtn.rx.tap.bind { [weak self] in
            guard let self = self else {return}
            let temp = self.mainView.fromTextField.text
            self.mainView.fromTextField.text = self.mainView.toTextField.text
            self.mainView.toTextField.text = temp

            self.mainView.inputValueTextField.text = "1"
            self.callCurrencyConversionAPI()
        }

    }

    func callCurrencyConversionAPI() {
        viewModel.getConvertedCurrency(fromSymbol: mainView.fromTextField.text!, toSymbol: mainView.toTextField.text!, valueToConvert: mainView.inputValueTextField.text!)
    }

}
