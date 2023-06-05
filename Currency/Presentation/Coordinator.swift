//
//  Coordinator.swift
//  Currency
//
//  Created by Khaled Bohout on 06/06/2023.
//

import UIKit

protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
