import Foundation

struct CurrencyRates: Codable {
    let success: Bool?
    let timestamp: Int?
    let base, date: String?
    let rates: [String: Double]?
}
