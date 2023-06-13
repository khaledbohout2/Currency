enum NetworkError: Error {
    case invalidAPIKey(String)
    case invalidSymbols(String)
    case decodingError(String)
    case APIRequestsReached(String)
    case internetError(String)
    case genericError(String)
}
