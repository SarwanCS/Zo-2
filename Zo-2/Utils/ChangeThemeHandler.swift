//
//  ChangeThemeHandler.swift
//  Zo-2
//
//  Created by Brian Heralall on 3/4/22.
//

import Foundation

class UserDefaultsUtils {
    static var shared = UserDefaultsUtils()
    func setDarkMode(enable: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(enable, forKey: Constants.DARK_MODE)
    }
    func getDarkMode() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: Constants.DARK_MODE)
    }
}


class Constants {
    public static let DARK_MODE = "DARK_MODE"
    public static let LIGHT_MODE = "LIGHT_MODE"
}
