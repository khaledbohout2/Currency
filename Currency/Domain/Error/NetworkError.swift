
enum NetworkError: Error {
    case invalidURL(String)
    case invalidResponse(String)
    case decodingError(String)
    case genericError(String)
    case internetError(String)
}
