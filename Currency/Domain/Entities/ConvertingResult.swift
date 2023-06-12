import Foundation

struct ConvertingResult: Codable {
    let success: Bool
    let rates: [String: Double]?
    let error: ErrorModel?
}
