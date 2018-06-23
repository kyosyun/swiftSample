//
//  ViewController.swift
//  realmSwiftSample
//
//  Created by 許　駿 on 2018/06/23.
//  Copyright © 2018年 kyo_s. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //realmのデータのリセット
    @IBAction func reset(_ sender: UIButton) {
        if let fileURL = Realm.Configuration.defaultConfiguration.fileURL {
            print(fileURL)
            try! FileManager.default.removeItem(at: fileURL)
        }
    }

    func createData() {
        let newDog = Dog()
        //オブジェクトを生成しプロパティに値をセット
        newDog.name = "Pochi"

        // デフォルトRealmを取得
        let realm = try! Realm()
        // トランザクションを開始して、オブジェクトをRealmに追加
        try! realm.write {
            let oldDog = realm.objects(Dog.self).sorted(byKeyPath: "id").last
            newDog.id = (oldDog?.id ?? 0) + 1
            realm.add(newDog)
        }
    }

    @IBAction func createData(_ sender: UIButton) {
        createData()
    }


    @IBAction func readData(_ sender: UIButton) {
        let realm = try! Realm()
        let dog = realm.objects(Dog.self)[0]
        print(dog.name)
    }

    @IBAction func update(_ sender: UIButton) {
        let realm = try! Realm()
        let dog = Dog()
        dog.id = 5
        dog.name = "hachi"
        try! realm.write {
            realm.add(dog, update: true)
        }
    }



}

