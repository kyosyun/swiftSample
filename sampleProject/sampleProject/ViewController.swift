//
//  ViewController.swift
//  sampleProject
//
//  Created by 許　駿 on 2018/05/02.
//  Copyright © 2018年 kyo_s. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultField: UITextField!
    @IBOutlet weak var textField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var actionBtn: UIButton!

    @IBAction func actionBtn(_ sender: UIButton) {
        resultField.text = resultField.text! + "\r\n\n\r" + textField.text!
    }
}

