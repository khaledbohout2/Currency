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
                    guard symbolsaData.success else {
                        self.handleError(error: symbolsaData.error)
                        return
                    }
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

    func handleError(error: ErrorModel?) {
        guard let error = error,
              let code = error.code else {return}
        if code == 101 {
            self.error.onNext(NetworkError.invalidAPIKey("No API Key was specified or an invalid API Key was specified."))
        } else if code == 104 {
            self.error.onNext(NetworkError.APIRequestsReached("The maximum allowed API amount of monthly API requests has been reached."))
        } else if code == 202 {
            self.error.onNext(NetworkError.invalidSymbols("One or more invalid symbols have been specified."))
        } else {
            self.error.onNext(NetworkError.genericError("some error happened, please try again later"))
        }
    }

    func navigateToDetails(baseCurrency: String, toCurrency: String) {
        cordinator.currencyDetails(baseCurrency: baseCurrency, toCurrency: toCurrency)
    }

}
