import Foundation

protocol GetSupportedSympolsUseCaseInterface {
    func perform() -> ObservableSupportedSymbolsData
}

final class GetSupportedSympolsUseCase: GetSupportedSympolsUseCaseInterface {

    private let currencyRepository: CurrencyRepositoryInterface

    init(currencyRepository: CurrencyRepositoryInterface) {
        self.currencyRepository = currencyRepository
    }

    func perform() -> ObservableSupportedSymbolsData {
        return currencyRepository.getSupportedSympols()
    }

}

