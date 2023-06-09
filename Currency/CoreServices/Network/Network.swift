import Foundation
import RxSwift
import RxCocoa

protocol NetworkProtocol {
    func send(apiRequest: APIRequest) -> Observable<Data>
}

class Network {
    private let baseURL = URL(string: "")!
    
    func send(apiRequest: APIRequest) -> Observable<Data> {
        let request = apiRequest.request(with: baseURL)
        return URLSession.shared.rx.data(request: request)
    }
}
