import Foundation

struct Constants {
    static var link: String {
        return "http://data.fixer.io"
    }

    static var baseUrl: String {
        return "\(link)/api"
    }

    static var accesskey: String {
        return "1e022e303cdabeabe1174e1935251b91"
    }

    static var popularCurrencies: [String] {
        return ["USD", "EUR", "JPY", "GBP", "AUD", "CAD", "CHF", "CNH", "HKD", "NZD"]
    }
}
