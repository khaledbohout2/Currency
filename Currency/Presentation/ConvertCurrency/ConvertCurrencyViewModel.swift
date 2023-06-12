import RxSwift
import RxCocoa 

final class ConvertCurrencyViewModel {

    public let currencySymbols: PublishSubject<[String]> = PublishSubject()
    public let convertedValue: PublishSubject<String> = PublishSubject()
    public let error: PublishSubject<Error> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()

    private let convertCurrencyUseCase: ConvertCurrencyUseCase
    private let getSupportedSympolsUseCase: GetSupportedSympolsUseCase

    private let disposeBag = DisposeBag()

    init(convertCurrencyUseCase: ConvertCurrencyUseCase,
         getSupportedSympolsUseCase: GetSupportedSympolsUseCase) {
        self.convertCurrencyUseCase = convertCurrencyUseCase
        self.getSupportedSympolsUseCase = getSupportedSympolsUseCase
    }

    func getValidCurrencySymbols() {
        getSupportedSympolsUseCase.perform().subscribe { [weak self] event in
            guard let self = self else {return}
            switch event {
            case .next(let result):
                switch result {
                case .success(let symbolsaData):
                    self.currencySymbols.onNext(symbolsaData.symbols?.keys.sorted() ?? [])
                case .failure(let error):
                    self.error.onNext(error)
                }
            case .error(let error):
                self.error.onNext(error)
            case .completed:
                break
            }
        }
        .disposed(by: disposeBag)
    }

    func getConvertedCurrency(fromSymbol: String, toSymbol: String, valueToConvert: String) {
        convertCurrencyUseCase.perform(from: fromSymbol, to: toSymbol, amount: valueToConvert).subscribe { [weak self] event in
            guard let self = self else {return}
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
                self.error.onNext(error)
            case .completed:
                break
            }
        }
        .disposed(by: disposeBag)
    }

}
