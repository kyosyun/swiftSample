//
//  PickerKeyboard.swift
//  PickerSample
//
//  Created by オフ on 2018/04/15.
//  Copyright © 2018年 kyo_s. All rights reserved.
//

import UIKit

class PickerKeyboard: UIControl {
    var data: [String] = ["data1","data2","data3"]
    fileprivate var textStore: String = ""
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // viewのタッチジェスチャーを取る
        addTarget(self, action: #selector(PickerKeyboard.didTap(sender:)), for: .touchDown)
    }
    
    // タッチされたらFirst Responderになる
    @objc func didTap(sender: PickerKeyboard) {
        becomeFirstResponder()
    }
    
    // First Responderになるためにはこのメソッドは常にtrueを返す必要がある
    func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    // inputViewをオーバーライドさせてシステムキーボードの代わりにPickerViewを表示
    override var inputView: UIView? {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        let row = data.index(of: textStore) ?? -1
        pickerView.selectRow(row, inComponent: 0, animated: false)
        return pickerView
    }
    
    override var inputAccessoryView: UIView? {
        // キーボードを閉じるための完了ボタン
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.addTarget(self, action: #selector(PickerKeyboard.didTapDone(sender:)), for: .touchDown)
        button.sizeToFit()
        
        // キーボードの上に置くアクセサリービュー
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 44))
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.backgroundColor = .groupTableViewBackground
        
        // ボタンをアクセサリービュー上に設置
        button.frame.origin.x = 16
        button.center.y = view.center.y
        button.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin, .flexibleTopMargin]
        view.addSubview(button)
        
        return view
    }
    
    // ボタンを押したらresignしてキーボードを閉じる
    @objc func didTapDone(sender: UIButton) {
        resignFirstResponder()
    }
    
}

// UIKeyInputを適用させる
extension PickerKeyboard: UIKeyInput {
    var hasText: Bool {
        return !textStore.isEmpty

    }
    
    
    // テキストが入力されたときに呼ばれる
    func insertText(_ text: String) {
        textStore += text
        setNeedsDisplay()
    }
    
    // バックスペースが入力されたときに呼ばれる
    func deleteBackward() {
        setNeedsDisplay()
    }
    
    // PickerViewで選択されたデータを表示する
    override func draw(_ rect: CGRect) {
        UIColor.black.set()
        UIRectFrame(rect)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attrs: [String: AnyObject] = [NSAttributedStringKey.font.rawValue: UIFont.systemFont(ofSize: 17), NSAttributedStringKey.paragraphStyle.rawValue: paragraphStyle]

    }
}

// UIPickerViewDelegateとDataSourceを実装して、dataの内容をピッカーへ表示させる
extension PickerKeyboard: UIPickerViewDelegate {
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // ピッカーから選択されたらその値をtextStoreへ入れる
        textStore = data[row]
        setNeedsDisplay()
    }
}
