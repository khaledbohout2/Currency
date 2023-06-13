import Foundation

protocol CurrencyRepositoryInterface {
    func convert(from: String, to: String, amount: String) -> ObservableRatesData
    func getSupportedSympols() -> ObservableSupportedSymbolsData
    func getHistoricalRates(date: String, base: String, symbol: String) -> ObservableHistoricalRatesData
}
