//
//  GetDatesForThreeDaysUseCase.swift
//  Currency
//
//  Created by Khaled Bohout on 13/06/2023.
//

import Foundation

protocol GetDatesForThreeDaysUseCaseInterface {
    func perform() ->[String]
}

class GetDatesForThreeDaysUseCase: GetDatesForThreeDaysUseCaseInterface {
    func perform() ->[String] {
        var dates = [String]()
        for from in 1...3 {
            guard let date = Date().getStringDateThreeDaysAgo(from: from) else {continue}
            dates.append(date)
        }
        return dates
    }
}
