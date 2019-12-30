//
//  ViewController.swift
//  UserDefinedRuntimeAttributesSaample
//
//  Created by 許　駿 on 2019/12/24.
//  Copyright © 2019年 kyo_s. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sampleView: UIView!
    override func viewDidLoad() {
        print(sampleView.layer.borderColor)
        super.viewDidLoad()
        print(sampleView.layer.borderColor)
        // Do any additional setup after loading the view, typically from a nib.
    }


}

