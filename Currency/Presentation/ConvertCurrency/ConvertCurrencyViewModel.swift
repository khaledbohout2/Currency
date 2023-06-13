import RxSwift
import RxCocoa 

final class ConvertCurrencyViewModel {

    public let currencySymbols: PublishSubject<[String]> = PublishSubject()
    public let convertedValue: PublishSubject<String> = PublishSubject()
    public let error: PublishSubject<NetworkError> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()

    private let convertCurrencyUseCase: ConvertCurrencyUseCase
    private let getSupportedSympolsUseCase: GetSupportedSympolsUseCase

    private let cordinator: MainCoordinator

    private let disposeBag = DisposeBag()

    init(convertCurrencyUseCase: ConvertCurrencyUseCase,
         getSupportedSympolsUseCase: GetSupportedSympolsUseCase,
         cordinator: MainCoordinator) {
        self.convertCurrencyUseCase = convertCurrencyUseCase
        self.getSupportedSympolsUseCase = getSupportedSympolsUseCase
        self.cordinator = cordinator
    }

    func getValidCurrencySymbols() {
        self.loading.onNext(true)
        getSupportedSympolsUseCase.perform().subscribe { [weak self] event in
            guard let self = self else {return}
            self.loading.onNext(false)
            switch event {
            case .next(let result):
                switch result {
                case .success(let symbolsaData):
                    self.currencySymbols.onNext(symbolsaData.symbols?.keys.sorted() ?? [])
                case .failure(let error):
                    self.error.onNext(error)
                }
            case .error(let error):
                guard let error = error as? NetworkError else {return}
                self.error.onNext(error)
            case .completed:
                break
            }
        }
        .disposed(by: disposeBag)
    }

    func getConvertedCurrency(fromSymbol: String, toSymbol: String, valueToConvert: String) {
        self.loading.onNext(true)
        convertCurrencyUseCase.perform(from: fromSymbol, to: [toSymbol], amount: valueToConvert).subscribe { [weak self] event in
            guard let self = self else {return}
            self.loading.onNext(false)
            switch event {
            case .next(let result):
                switch result {
                case .success(let convertedData):
                    guard let value = convertedData.rates?[toSymbol] else {return}
                    self.convertedValue.onNext(String(format: "%.3f", value))
                case .failure(let error):
                    self.error.onNext(error)
                }
            case .error(let error):
                guard let error = error as? NetworkError else {return}
                self.error.onNext(error)
            case .completed:
                break
            }
        }
        .disposed(by: disposeBag)
    }

    func navigateToDetails(baseCurrency: String, toCurrency: String) {
        cordinator.currencyDetails(baseCurrency: baseCurrency, toCurrency: toCurrency)
    }

}
