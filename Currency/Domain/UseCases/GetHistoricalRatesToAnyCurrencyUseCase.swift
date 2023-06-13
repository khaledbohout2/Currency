import Foundation

protocol ConvertFromEuroUseCaseInterface {
    func perform(rates: HistoricalRates ,myBase: String, toCurrency: String) -> HistoricalRates
}

class ConvertFromEuroUseCase: ConvertFromEuroUseCaseInterface {
    func perform(rates: HistoricalRates ,myBase: String, toCurrency: String) -> HistoricalRates {
        let newValues = rates.rates?.mapValues { $0 * (rates.rates?[myBase] ?? 0.0) }
        var newRates = rates
        newRates.rates = newValues
        newRates.toCurrency = toCurrency
        newRates.base = myBase
        return newRates
    }
}
