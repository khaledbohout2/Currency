import Foundation

struct HistoricalRates: Codable {
    let success, historical: Bool?
    let date: String?
    let timestamp: Int?
    let base: String?
    let rates: [String: String]?
}
