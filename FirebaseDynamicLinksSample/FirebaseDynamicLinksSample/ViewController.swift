//
//  ViewController.swift
//  FirebaseDynamicLinksSample
//
//  Created by 許　駿 on 2019/02/19.
//  Copyright © 2019年 kyo_s. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var text: UITextView!

    @IBOutlet weak var btn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btnTapped(_ sender: UIButton) {
        text.text = UserDefaults.standard.url(forKey: "url")?.absoluteString
    }
}

