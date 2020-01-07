//
//  Foundation+NSLocalizedString.swift
//  LocalizedStringSample
//
//  Created by 許　駿 on 2020/01/05.
//  Copyright © 2020年 kyo_s. All rights reserved.
//

import Foundation

func NSLocalizedString(key: String, tableName: String? = nil, bundle: Bundle = Bundle.main, value: String = "", comment: String) -> String {

    var bundleToUse = bundle
    let languageCd = AppEnvironment.shared.lang.rawValue
    if let path = bundle.path(forResource: languageCd, ofType: "lproj"), let bundle = Bundle(path: path) {
        bundleToUse = bundle
    }

    return Foundation.NSLocalizedString(key, tableName: tableName, bundle: bundleToUse, value: value, comment: comment)
}
