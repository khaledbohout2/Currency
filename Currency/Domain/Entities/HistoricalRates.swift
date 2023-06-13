import Foundation

struct HistoricalRates: Codable {
    let success: Bool
    let historical: Bool?
    let date: String?
    let timestamp: Int?
    var base: String?
    var rates: [String: Double]?
    var toCurrency: String?
    let error: ErrorModel?
}
