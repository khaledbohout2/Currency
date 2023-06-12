import Foundation
import RxSwift

typealias ObservableRatesData = Observable<Result<ConvertingResult, Error>>
typealias ObservableSupportedSymbolsData = Observable<Result<SupportedSymbols, Error>>
typealias ObservableHistoricalRatesData = Observable<Result<HistoricalRates, Error>>

protocol CurrencyAPIServiceInterface {
    func convert(from: String, to: String, amount: String) -> ObservableRatesData
    func getSuppotedSymbols() -> ObservableSupportedSymbolsData
    func getHistoricalRates(date: String, base: String, symbols: String) -> ObservableHistoricalRatesData
}

class CurrencyAPIService: CurrencyAPIServiceInterface {

    private let network: NetworkProtocol

    init(network: NetworkProtocol) {
        self.network = network
    }

    func convert(from: String, to: String, amount: String) -> ObservableRatesData {
        let request = CurrencyEndPoint.convert(from: from, to: to, amount: amount)
        return network.send(apiRequest: request, decodeTo: ConvertingResult.self)
    }

    func getSuppotedSymbols() -> ObservableSupportedSymbolsData {
        let request = CurrencyEndPoint.getSupportedSymbols
        return network.send(apiRequest: request, decodeTo: SupportedSymbols.self)
    }

    func getHistoricalRates(date: String, base: String, symbols: String) -> ObservableHistoricalRatesData {
        let request = CurrencyEndPoint.getHistoricalRates(date: date, base: base, symbols: symbols)
        return network.send(apiRequest: request, decodeTo: HistoricalRates.self)
    }

}
