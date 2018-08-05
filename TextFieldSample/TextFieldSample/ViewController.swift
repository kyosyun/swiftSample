//
//  ViewController.swift
//  TextFieldSample
//
//  Created by 許　駿 on 2018/08/05.
//  Copyright © 2018年 kyo_s. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!

    override func viewWillAppear(_ animated: Bool) {
        //TextViewに枠をつける
        // 枠のカラー
        textView.layer.borderColor = UIColor.lightGray.cgColor

        // 枠の幅
        textView.layer.borderWidth = 0.3

        // 枠を角丸にする場合
        textView.layer.cornerRadius = 10.0
        textView.layer.masksToBounds = true
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

