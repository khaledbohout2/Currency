import Foundation

protocol CurrencyRepositoryInterface {
    func convert(base: String, sympols: String) -> ObservableRatesData
    func getSupportedSympols() -> ObservableSupportedSymbolsData
}
