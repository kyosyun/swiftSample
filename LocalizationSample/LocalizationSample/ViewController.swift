//
//  ViewController.swift
//  LocalizationSample
//
//  Created by 許　駿 on 2019/12/12.
//  Copyright © 2019年 kyo_s. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var localizedString: UILabel!

    @IBOutlet weak var img: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        localizedString.text = NSLocalizedString("LocalizationStringKey", comment: "comment")
        print(NSLocalizedString("test", comment: ""))
        img.image = UIImage(named: NSLocalizedString("img", comment: ""))
    }
}

