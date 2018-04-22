//
//  ViewController.swift
//  OnOffButtonSample
//
//  Created by 許　駿 on 2018/04/22.
//  Copyright © 2018年 kyo_s. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var OnOffButton1: OnOffButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func OnOffButton1Tapped(_ sender: OnOffButton) {
        if(sender.isButtonSelected) {
            sender.isButtonSelected = false
        } else {
            sender.isButtonSelected = true
        }
        if(sender.isButtonSelected){
            sender.backgroundColor = UIColor.black
        } else {
            sender.backgroundColor = UIColor.blue
        }
    }

}


class OnOffButton: UIButton {
    var isButtonSelected: Bool = false

}
