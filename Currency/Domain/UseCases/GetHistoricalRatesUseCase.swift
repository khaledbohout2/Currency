import Foundation

protocol GetHistoricalRatesUseCaseInterface {
    func perform(base: String, symbol: String, date: String) -> ObservableHistoricalRatesData
}

final class GetHistoricalRatesUseCase: GetHistoricalRatesUseCaseInterface {

    private let currencyRepository: CurrencyRepositoryInterface

    init(currencyRepository: CurrencyRepositoryInterface) {
        self.currencyRepository = currencyRepository
    }

    func perform(base: String, symbol: String, date: String) -> ObservableHistoricalRatesData {
        return currencyRepository.getHistoricalRates(date: date, base: base, symbol: symbol)
    }

}
