//
//  UIViewController+parseNetworkError.swift
//  Currency
//
//  Created by Khaled Bohout on 12/06/2023.
//

import UIKit

extension UIViewController {
    func parseNetworkError() {
        func parseNetworkError(error: NetworkError) {
            var errorMessage = ""
            switch error {
            case .invalidURL(let message):
                errorMessage = message
            case .invalidResponse(let message):
                errorMessage = message
            case .decodingError(let message):
                errorMessage = message
            case .genericError(let message):
                errorMessage = message
            case .internetError(let message):
                errorMessage = message

            }

       //     showErrorView(errorMessage: errorMessage)
        }
    }
}
