import Foundation

struct SupportedSymbols: Codable {
    let success: Bool
    let symbols: [String: String]?
    let error: ErrorModel?
}
