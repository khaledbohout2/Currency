import Foundation

protocol GetHistoricalRatesUseCaseInterface {
    func perform() -> ObservableHistoricalRatesData
}

final class GetHistoricalRatesUseCase: GetHistoricalRatesUseCaseInterface {

    private let currencyRepository: CurrencyRepositoryInterface
    private let base: String
    private let symbols: [String]

    init(currencyRepository: CurrencyRepositoryInterface,
         base: String,
         symbols: [String]) {
        self.currencyRepository = currencyRepository
        self.base = base
        self.symbols = symbols
    }

    func perform() -> ObservableHistoricalRatesData {
        return currencyRepository.getHistoricalRates(date: Date().getStringDateThreeDaysAgo() ?? "", base: base, symbols: symbols.joined(separator: ","))
    }

}
