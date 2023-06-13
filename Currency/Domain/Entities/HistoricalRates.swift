import Foundation

struct HistoricalRates: Codable {
    let success: Bool
    let date: String?
    var base: String?
    var rates: [String: Double]?
    var toCurrency: String?
    let error: ErrorModel?
}
