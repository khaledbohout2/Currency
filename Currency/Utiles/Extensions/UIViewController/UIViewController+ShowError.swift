//
//  UIViewController+parseNetworkError.swift
//  Currency
import UIKit

extension UIViewController {

        func parseNetworkError(error: NetworkError) {
            var errorMessage = ""
            switch error {
            case .decodingError(let message):
                errorMessage = message
            case .genericError(let message):
                errorMessage = message
            case .internetError(let message):
                errorMessage = message
            case .invalidAPIKey(let message):
                errorMessage = message
            case .invalidSymbols(let message):
                errorMessage = message
            case .APIRequestsReached(let message):
                errorMessage = message
            }

            showErrorView(errorMessage: errorMessage)
        }


    func showErrorView(errorMessage: String) {
        let errorDialogMessage = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)


        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)

        //Add OK button to a dialog message
        errorDialogMessage.addAction(ok)
        // Present alert to user
        self.present(errorDialogMessage, animated: true, completion: nil)
    }
}
