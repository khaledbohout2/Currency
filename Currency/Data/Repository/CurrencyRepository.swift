import Foundation

final class CurrencyRepository: CurrencyRepositoryInterface {

    private let currencyAPIService: CurrencyAPIServiceInterface

    init(currencyAPIService: CurrencyAPIServiceInterface) {
        self.currencyAPIService = currencyAPIService
    }

    func convert(base: String, sympols: String) -> ObservableRatesData {
        return currencyAPIService.convert(base: base, symbols: sympols)
    }

    func getSupportedSympols() -> ObservableSupportedSymbolsData {
        return currencyAPIService.getSuppotedSymbols()
    }

    func getHistoricalRates(date: String, base: String, symbols: String) -> ObservableHistoricalRatesData {
        return currencyAPIService.getHistoricalRates(date: date, base: base, symbols: symbols)
    }
}
