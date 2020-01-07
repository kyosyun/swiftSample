//
//  AppEnvironment.swift
//  LocalizableStringSample
//
//  Created by 許　駿 on 2020/01/08.
//  Copyright © 2020年 kyo_s. All rights reserved.
//

import Foundation

class AppEnvironment {
    static let shared = AppEnvironment()
    fileprivate let userDefaults = UserDefaults.standard

    fileprivate enum Keys: String {
        case LANG = "KEY_LANG"
    }

    var lang: Lang {
        set(val) {
            userDefaults.setEnum(val, forKey: Keys.LANG.rawValue)
        }
        get {
            return userDefaults.getEnum(forKey: Keys.LANG.rawValue) ?? Lang.EN
        }
    }
}
