//
//  ViewController.swift
//  RealmSample
//
//  Created by 許　駿 on 2019/08/13.
//  Copyright © 2019年 kyo_s. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var ageText: UITextField!

    @IBOutlet weak var loadText: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func save(_ sender: UIButton) {
        guard let name = nameText.text, let age = Int(ageText.text ?? "0") else {
            return
        }
        _ = DogRepository.createDog(name: name, age: age)
    }

    @IBAction func load(_ sender: UIButton) {
        loadText.text = DogRepository.loadAll().description
    }



}

