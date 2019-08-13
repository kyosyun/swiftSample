//
//  Realm.swift
//  RealmSample
//
//  Created by 許　駿 on 2019/08/13.
//  Copyright © 2019年 kyo_s. All rights reserved.
//

import RealmSwift

extension Realm {
    static let SCHEMA_VERSION_0_1_0 = UInt64(0101) //0.1.0

    static func updateRealmConfiguration() {
        var config = Realm.Configuration.defaultConfiguration
        config.schemaVersion = SCHEMA_VERSION_0_1_0
        config.migrationBlock = { migration, oldSchemaVersion in
            if (oldSchemaVersion < SCHEMA_VERSION_0_1_0) {
                // do noting 新規追加・削除されたプロパティに関しては自動で認識する
            }
        }
        // defaultConfiguration に設定を保持する。
        Realm.Configuration.defaultConfiguration = config
    }

}


