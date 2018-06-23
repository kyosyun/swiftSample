//
//  Doc.swift
//  realmSwiftSample
//
//  Created by 許　駿 on 2018/06/23.
//  Copyright © 2018年 kyo_s. All rights reserved.
//

import RealmSwift

class Dog: Object {

    @objc dynamic var id = 0
    @objc dynamic var name = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}
