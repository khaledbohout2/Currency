import Foundation
import RxSwift

typealias ObservableRatesData = Observable<CurrencyRates>
typealias ObservableSupportedSymbolsData = Observable<SupportedSymbols>
typealias ObservableHistoricalRatesData = Observable<HistoricalRates>

protocol CurrencyAPIServiceInterface {
    func convert(base: String, symbols: String) -> ObservableRatesData
    func getSuppotedSymbols() -> ObservableSupportedSymbolsData
    func getHistoricalRates(date: String, base: String, symbols: String) -> ObservableHistoricalRatesData
}

class CurrencyAPIService: CurrencyAPIServiceInterface {

    private let network: NetworkProtocol
    init(network: NetworkProtocol) {
        self.network = network
    }

    func convert(base: String, symbols: String) -> ObservableRatesData {
        let request = CurrencyEndPoint.convert(base: base, symbols: symbols)
        return network.send(apiRequest: request)
            .map {
                try JSONDecoder().decode(CurrencyRates.self, from: $0)
            }
    }

    func getSuppotedSymbols() -> ObservableSupportedSymbolsData {
        let request = CurrencyEndPoint.getSupportedSymbols
        return network.send(apiRequest: request)
            .map {
                try JSONDecoder().decode(SupportedSymbols.self, from: $0)
            }
    }

    func getHistoricalRates(date: String, base: String, symbols: String) -> ObservableHistoricalRatesData {
        let request = CurrencyEndPoint.getHistoricalRates(date: date, base: base, symbols: symbols)
        return network.send(apiRequest: request)
            .map {
                try JSONDecoder().decode(HistoricalRates.self, from: $0)
            }
    }
}
