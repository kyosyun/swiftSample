//
//  ViewController.swift
//  ExpansionButtonSample
//
//  Created by 許駿 on 2020/05/07.
//  Copyright © 2020 kyo_s. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button: ExpansionButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        button.insets = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
    }
    
    @IBAction func taped(_ sender: UIButton) {
        print("hello")
    }
}

