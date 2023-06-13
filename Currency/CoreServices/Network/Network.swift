import Foundation
import RxSwift
import RxCocoa

protocol NetworkProtocol {
    func send<T: Codable>(apiRequest: APIRequest, decodeTo type: T.Type) -> Observable<Result<T, NetworkError>>
}

class Network: NetworkProtocol {
    func send<T: Codable>(apiRequest: APIRequest, decodeTo type: T.Type) -> Observable<Result<T, NetworkError>> {
        return Observable.create { observer in
            let request = apiRequest.request()
            var task = URLSession.shared.dataTask(with: request)
            var result: Result<T, NetworkError>?
            task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data, let response = response as? HTTPURLResponse,  response.statusCode == 200 {
                    do {
                        let model: T = try JSONDecoder().decode(T.self, from: data)
                        result = Result<T, NetworkError>.success(model)
                        observer.onNext(result!)
                        observer.onCompleted()
                        debugPrint(model)
                    } catch let error {
                        result = Result<T, NetworkError>.failure(NetworkError.decodingError("Invalid Response received."))
                        observer.onError(error)
                        observer.onCompleted()
                        debugPrint(error)
                    }
                } else {
                    if let error = error {
                        result = Result<T, NetworkError>.failure(NetworkError.decodingError("Something unexpected occured."))
                        observer.onError(error)
                        observer.onCompleted()
                        debugPrint(error)
                    }
                }
                observer.onNext(result!)
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }

}
