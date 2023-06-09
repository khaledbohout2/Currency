import Foundation

enum CurrencyEndPoint: APIRequest {

    case convert(base: String, symbols: String)
    case getSupportedSymbols
    case getHistoricalRates(date: String, base: String, symbols: String)

    var method: RequestType {
        switch self {
        case .convert:
            return .POST
        case .getSupportedSymbols, .getHistoricalRates:
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
        case .convert(let base, let symbols):
            return ["base" : base, "symbols": symbols, "access_key": Constants.accesskey]
        case .getHistoricalRates(_, let base, let symbols):
            return ["base" : base, "symbols": symbols, "access_key": Constants.accesskey]
        default: return ["access_key": Constants.accesskey]
        }
    }

}
