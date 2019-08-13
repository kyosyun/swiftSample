//
//  Dog.swift
//  RealmSample
//
//  Created by 許　駿 on 2019/08/13.
//  Copyright © 2019年 kyo_s. All rights reserved.
//

import Foundation
import RealmSwift

class Dog: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var age = 0


    override static func primaryKey() -> String {
        return "id"
    }
}

class DogRepository {
    static func createDog(name: String, age: Int) -> Dog {
        let dog = Dog()
        dog.name = name
        dog.age = age

        Realm.updateRealmConfiguration()
        let realm = try! Realm()
        try! realm.write {
            realm.add(dog, update: true)
        }
        return dog
    }

    static func loadAll() -> [Dog] {
        Realm.updateRealmConfiguration()
        let realm = try! Realm()
        return Array(realm.objects(Dog.self))
    }
}


