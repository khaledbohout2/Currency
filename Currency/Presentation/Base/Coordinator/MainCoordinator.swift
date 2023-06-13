import UIKit

final class MainCoordinator: Coordinator {

    var children = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let currencyAPIService = CurrencyAPIService(network: Network())
        let currencyRepository = CurrencyRepository(currencyAPIService: currencyAPIService)
        let convertCurrencyUseCase = ConvertCurrencyUseCase(currencyRepository: currencyRepository)
        let getSupportedSympolsUseCase = GetSupportedSympolsUseCase(currencyRepository: currencyRepository)
        let vModel = ConvertCurrencyViewModel(convertCurrencyUseCase: convertCurrencyUseCase, getSupportedSympolsUseCase: getSupportedSympolsUseCase, cordinator: self)
        let vCont = ConvertCurrencyVC(viewModel: vModel)
        navigationController.pushViewController(vCont, animated: true)
    }

    func currencyDetails(baseCurrency: String, toCurrency: String) {
        let currencyAPIService = CurrencyAPIService(network: Network())
        let currencyRepository = CurrencyRepository(currencyAPIService: currencyAPIService)
        let getHistoricalRatesUseCase = GetHistoricalRatesUseCase(currencyRepository: currencyRepository)
        let getDatesForThreeDaysUseCase = GetDatesForThreeDaysUseCase()
        let convertFromEuroUseCase = ConvertFromEuroUseCase()
        let convertCurrencyUseCase = ConvertCurrencyUseCase(currencyRepository: currencyRepository)
        let vModel = CurrencyDetailsViewModel(baseCurrency: baseCurrency,
                                              toCurrency: toCurrency,
                                              getHistoricalRatesUseCase: getHistoricalRatesUseCase,
                                              getDatesForThreeDaysUseCase: getDatesForThreeDaysUseCase,
                                              convertFromEuroUseCase: convertFromEuroUseCase,
                                              convertCurrencyUseCase: convertCurrencyUseCase,
                                              cordinator: self)
        let vCont = CurrencyDetailsVC(viewModel: vModel)
        navigationController.pushViewController(vCont, animated: true)
    }

}
