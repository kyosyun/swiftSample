//
//  ViewController.swift
//  TextViewWithPlaceHolder
//
//  Created by 許　駿 on 2019/08/18.
//  Copyright © 2019年 kyo_s. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

