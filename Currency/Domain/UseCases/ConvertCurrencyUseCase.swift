import Foundation

final class ConvertCurrencyUseCase {

    private let currencyRepository: CurrencyRepositoryInterface
    private let base: String
    private let symbols: String

    init(currencyRepository: CurrencyRepositoryInterface,
         base: String,
         symbols: String) {
        self.currencyRepository = currencyRepository
        self.base = base
        self.symbols = symbols
    }

    func perform() -> ObservableRatesData {
        return currencyRepository.convert(base: base, sympols: symbols)
    }

}
