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
        let vModel = ConvertCurrencyViewModel(convertCurrencyUseCase: convertCurrencyUseCase, getSupportedSympolsUseCase: getSupportedSympolsUseCase)
        let vCont = ConvertCurrencyVC(viewModel: vModel)
        navigationController.pushViewController(vCont, animated: true)
    }

}
