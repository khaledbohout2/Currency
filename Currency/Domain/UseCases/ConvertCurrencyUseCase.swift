import Foundation

protocol ConvertCurrencyUseCaseInterface {
     func perform(from: String, to: [String], amount: String) -> ObservableRatesData
}

final class ConvertCurrencyUseCase: ConvertCurrencyUseCaseInterface {

    private let currencyRepository: CurrencyRepositoryInterface

    init(currencyRepository: CurrencyRepositoryInterface) {
        self.currencyRepository = currencyRepository
    }

    func perform(from: String, to: [String], amount: String) -> ObservableRatesData {
        return currencyRepository.convert(from: from, to: to.joined(separator: ", "), amount: amount)
    }

}
