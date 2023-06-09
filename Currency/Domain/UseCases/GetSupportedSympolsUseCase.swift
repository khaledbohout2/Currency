import Foundation

final class GetSupportedSympolsUseCase {

    private let currencyRepository: CurrencyRepositoryInterface

    init(currencyRepository: CurrencyRepositoryInterface) {
        self.currencyRepository = currencyRepository
    }

    func perform() -> ObservableSupportedSymbolsData {
        return currencyRepository.getSupportedSympols()
    }

}

