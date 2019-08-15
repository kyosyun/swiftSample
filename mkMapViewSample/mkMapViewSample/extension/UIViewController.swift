//
//  UIViewController.swift
//  mkMapViewSample
//
//  Created by 許　駿 on 2019/08/15.
//  Copyright © 2019年 kyo_s. All rights reserved.
//
import UIKit

extension UIViewController {
    @objc func endEditing() {
        view.endEditing(true)
    }

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
