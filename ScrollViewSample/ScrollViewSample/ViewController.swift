//
//  ViewController.swift
//  ScrollViewSample
//
//  Created by 許　駿 on 2019/08/19.
//  Copyright © 2019年 kyo_s. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!

    var txtActiveField = UITextField()
    var ajustedCGFloat = CGFloat()

    override func viewDidLoad() {
        super.viewDidLoad()
        textField1.delegate = self
        textField2.delegate = self
        textField3.delegate = self
        textField4.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // キーボードの処理を検知する
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(ViewController.handleKeyboardWillShowNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(ViewController.handleKeyboardWillHideNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        // キーボードの処理検知を除外する
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func handleKeyboardWillShowNotification(notification: NSNotification) {
        let userInfo = notification.userInfo!

        // キーボードの大きさ
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue

        // 画面のサイズ
        let myBoundSize: CGSize = UIScreen.main.bounds.size

        // テキストの下部の位置
        let txtUnder = txtActiveField.frame.origin.y + txtActiveField.frame.height + 20.0

        // キードード上部の位置
        let kbdUpper = myBoundSize.height - keyboardScreenEndFrame.size.height

        print("テキストフィールドの下辺:\(txtUnder)")
        print("キーボードの上限: \(kbdUpper)")

        if txtUnder >= kbdUpper {
            ajustedCGFloat = txtUnder - kbdUpper
            scrollView.contentOffset.y = ajustedCGFloat
        }
    }

    @objc func handleKeyboardWillHideNotification(notification: NSNotification) {
        if scrollView.contentOffset.y - ajustedCGFloat < 0 {
            scrollView.contentOffset.y = 0
        } else {
            scrollView.contentOffset.y = scrollView.contentOffset.y - ajustedCGFloat
        }
    }

}
extension ViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        txtActiveField = textField
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

}
