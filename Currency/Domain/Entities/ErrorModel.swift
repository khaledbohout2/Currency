import Foundation

struct ErrorModel: Codable {
    let code: Int
    let type, info: String
}
