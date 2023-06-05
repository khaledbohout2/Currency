//
//  AppDelegate+appearance.swift
//  Currency
//
//  Created by Khaled Bohout on 06/06/2023.
//

import UIKit

extension AppDelegate {
    func setAppearance() {
        setNavigationAppearance()
        setImageViewAppearance()
    }

    func setNavigationAppearance() {
            UINavigationBar.appearance().tintColor = .black
            UINavigationBar.appearance().shadowImage = UIImage()
            UINavigationBar.appearance().backgroundColor = .white
        UINavigationBar.appearance().isTranslucent = false
    }

    func setImageViewAppearance() {
        UIImageView.appearance().contentMode = .scaleAspectFill
        UIImageView.appearance().clipsToBounds = true
    }
}
