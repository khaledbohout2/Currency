import Foundation

protocol CurrencyRepositoryInterface {
    func convert(base: String, sympols: String) -> ObservableRatesData
    func getSupportedSympols() -> ObservableSupportedSymbolsData
    func getHistoricalRates(date: String, base: String, symbols: String) -> ObservableHistoricalRatesData
}
