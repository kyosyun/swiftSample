//
//  UIViewController.swift
//  navigationSample
//
//  Created by 許　駿 on 2018/08/05.
//  Copyright © 2018年 kyo_s. All rights reserved.
//

import UIKit

extension UIViewController {

    func createSimpleAlertDialg(title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        return alertController
    }

    func createSimpleAlertDialg(title: String, message: String, completion: ((UIAlertAction) -> Void)?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: completion)
        alertController.addAction(okAction)
        return alertController
    }

    @objc func endiEditing() {
        view.endEditing(true)
    }
}

protocol UIStoryboardInstatiatable {}

extension UIViewController: UIStoryboardInstatiatable {}

extension UIStoryboardInstatiatable where Self: UIViewController {

    //Storyboardの生成の共通クラス
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: self.className, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: self.className) as! Self
    }
}
