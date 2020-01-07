//
//  L10nExtention.swift
//  LocalizableStringSample
//
//  Created by 許　駿 on 2020/01/05.
//  Copyright © 2020年 kyo_s. All rights reserved.
//

import Foundation

extension L10n {
    static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> LocalizableKey {
        // swiftlint:disable:next nslocalizedstring_key

        return LocalizableKey(table: table, key: key, args: args)
    }
}

struct LocalizableKey {
    let table: String
    let key: String
    let args: [CVarArg]
    let value: String = ""
    let comment: String = ""

    func tr() -> String {
        let bundle = Bundle.main
        var bundleToUse = bundle
        let lang = AppEnvironment.shared.lang.rawValue
        if let path = bundle.path(forResource: lang, ofType: "lproj"), let bundle = Bundle(path: path) {
            bundleToUse = bundle
        }

        let format = Foundation.NSLocalizedString(key, tableName: table, bundle: bundleToUse, value: value, comment: comment)
        return String(format: format, arguments: args)
    }
}

//extension L10n {
//    private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
//        // swiftlint:disable:next nslocalizedstring_key
//        let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
//        return String(format: format, locale: Locale.current, arguments: args)
//    }
//}
//
//private final class BundleToken {}
