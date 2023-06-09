import Foundation

enum CurrencyEndPoint: APIRequest {

case login(email: String, password: String)

    var method: RequestType {
        return .POST
    }

    var path: String {
        switch self {
        case .login:
            return "auth/login"
        }
    }

    var parameters: [String : String] {
        switch self {
        case .login(let email, let password):
            return ["" : ""]
        }
    }


}
