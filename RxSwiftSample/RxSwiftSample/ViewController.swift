//
//  ViewController.swift
//  RxSwiftSample
//
//  Created by 許　駿 on 2019/12/30.
//  Copyright © 2019年 kyo_s. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.textField
            .rx
            .text
            .bind(to: self.label.rx.text)
            .disposed(by: self.disposeBag)
    }


}

