import Foundation
import RxSwift
import RxCocoa

class Network {
    private let baseURL = URL(string: "")!

    func send<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
        let request = apiRequest.request(with: baseURL)
        return URLSession.shared.rx.data(request: request)
            .map {
                try JSONDecoder().decode(T.self, from: $0)
            }
    }
}
