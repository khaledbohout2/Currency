import Foundation

enum CurrencyEndPoint: APIRequest {

    case convert(from: String, to: String, amount: String)
    case getSupportedSymbols
    case getHistoricalRates(date: String, base: String, symbols: String)

    var method: RequestType {
        switch self {
        case .convert:
            return .GET
        case .getSupportedSymbols:
            return .GET
        case .getHistoricalRates:
            return .GET
        }
    }

    var url: URL {
        return URL(string: "\(Constants.baseUrl)/")!
            .appendingPathComponent(path)
    }

    var path: String {
        switch self {
        case .convert:
            return "latest"
        case .getSupportedSymbols:
            return "symbols"
        case .getHistoricalRates(let date, _, _):
            return "\(date)"
        }
    }

    var parameters: [String : String] {
        switch self {
        case .getSupportedSymbols:
            return ["access_key": Constants.accesskey]
        case .convert(let from, let to, let amount):
            return ["from" : from, "symbols": to, "amount": amount, "access_key": Constants.accesskey]
        case .getHistoricalRates(_, let base, let symbols):
            return ["base" : "EUR", "symbols": "\(symbols), \(base)", "access_key": Constants.accesskey]
        }
    }

}
