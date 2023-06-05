//
//  MainCoordinator.swift
//  Currency
//
//  Created by Khaled Bohout on 06/06/2023.
//

import UIKit

final class MainCoordinator: Coordinator {

    var children = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {}
    
}
