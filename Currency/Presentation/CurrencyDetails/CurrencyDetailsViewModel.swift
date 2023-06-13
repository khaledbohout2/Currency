import Foundation
import RxSwift
import RxCocoa

class CurrencyDetailsViewModel {

    public let popularCurrencies: PublishSubject<[String: Double]> = PublishSubject()
    public let historicalDataModel: PublishSubject<[HistoricalRates]> = PublishSubject()
    public let error: PublishSubject<NetworkError> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()

    private let baseCurrency: String
    private let toCurrency: String

    private let getHistoricalRatesUseCase: GetHistoricalRatesUseCaseInterface
    private let getDatesForThreeDaysUseCase: GetDatesForThreeDaysUseCaseInterface
    private let getSupportedSympolsUseCase: GetSupportedSympolsUseCaseInterface
    private let convertFromEuroUseCase: ConvertFromEuroUseCaseInterface
    private let convertCurrencyUseCase: ConvertCurrencyUseCaseInterface

    private let cordinator: MainCoordinator

    var historicalRates = [HistoricalRates]()

    private let disposeBag = DisposeBag()

    init(baseCurrency: String,
         toCurrency: String,
         getHistoricalRatesUseCase: GetHistoricalRatesUseCaseInterface,
         getDatesForThreeDaysUseCase: GetDatesForThreeDaysUseCaseInterface,
         getSupportedSympolsUseCase: GetSupportedSympolsUseCase,
         convertFromEuroUseCase: ConvertFromEuroUseCaseInterface,
         convertCurrencyUseCase: ConvertCurrencyUseCaseInterface,
         cordinator: MainCoordinator) {
        self.baseCurrency = baseCurrency
        self.toCurrency = toCurrency
        self.getHistoricalRatesUseCase = getHistoricalRatesUseCase
        self.getDatesForThreeDaysUseCase = getDatesForThreeDaysUseCase
        self.getSupportedSympolsUseCase = getSupportedSympolsUseCase
        self.convertFromEuroUseCase = convertFromEuroUseCase
        self.convertCurrencyUseCase = convertCurrencyUseCase
        self.cordinator = cordinator
    }

    func getHistoricalRates() {
        loading.onNext(true)
        let dispatchGroup = DispatchGroup()
        for date in getDatesForThreeDaysUseCase.perform() {
            dispatchGroup.enter()
            getHistoricalRatesUseCase.perform(base: baseCurrency, symbol: toCurrency, date: date).subscribe { [weak self] event in
                guard let self = self else {return}
                switch event {
                case .next(let result):
                    switch result {
                    case .success(let ratesData):
                        self.historicalRates.append(self.convertFromEuroUseCase.perform(rates: ratesData, myBase: self.baseCurrency, toCurrency: self.toCurrency))
                        dispatchGroup.leave()
                    case .failure(let error):
                        self.error.onNext(error)
                        dispatchGroup.leave()
                    }
                case .error(let error):
                    guard let error = error as? NetworkError else {return}
                    self.error.onNext(error)
                    dispatchGroup.leave()
                case .completed:
                    break
                }
            }
            .disposed(by: disposeBag)
        }
        dispatchGroup.notify(queue: .main) {
            self.historicalDataModel.onNext(self.historicalRates)
            self.loading.onNext(false)
        }
    }

    func getPopularConventions() {
        loading.onNext(true)
        convertCurrencyUseCase.perform(from: baseCurrency, to: Constants.popularCurrencies, amount: "1").subscribe { [weak self] event in
            guard let self = self else {return}
            switch event {
            case .next(let result):
                switch result {
                case .success(let convertedData):
                    guard let rates = convertedData.rates else {return}
                    self.popularCurrencies.onNext(rates)
                case .failure(let error):
                    self.error.onNext(error)
                }
            case .error(let error):
                guard let error = error as? NetworkError else {return}
                self.error.onNext(error)
            case .completed:
                break
            }
            self.loading.onNext(false)
        }
        .disposed(by: disposeBag)
    }

}
