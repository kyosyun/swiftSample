//
//  ViewController.swift
//  PaintSample
//
//  Created by 許　駿 on 2018/04/30.
//  Copyright © 2018年 kyo_s. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    @IBOutlet weak var paintImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let paintImageView = PaintImageView.init(image: #imageLiteral(resourceName: "SamplePic"))
        paintImageView.frame = self.view.frame
        self.view.addSubview(paintImageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

