//
//  UserDefaults+EnumExtension.swift
//  LocalizableStringSample
//
//  Created by 許　駿 on 2020/01/08.
//  Copyright © 2020年 kyo_s. All rights reserved.
//

import Foundation

// UserDefaultsにて、Enumの保存が出来るようにするExtension
extension UserDefaults {
    func setEnum<T: RawRepresentable>(_ val: T?, forKey key: String) where T.RawValue ==  String {
        if let val = val {
            set(val.rawValue, forKey: key)
        } else {
            removeObject(forKey: key)
        }
    }

    func getEnum<T: RawRepresentable>(forKey key: String) -> T? where T.RawValue == String {
        if let str = string(forKey: key) {
            return T(rawValue: str)
        }
        return nil
    }
}
