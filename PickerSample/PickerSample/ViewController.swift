//
//  ViewController.swift
//  PickerSample
//
//  Created by オフ on 2018/04/15.
//  Copyright © 2018年 kyo_s. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var list = ["list1","list2","list3"]
    @IBOutlet weak var textField: UITextField!
    let pickerView = UIPickerView()
    
    let weekPickerView = WeekPickerView()
    @IBOutlet weak var weekTextField: WeekTextFieldPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ////// init ToolBar //////////////////////////////////////
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: UIViewController(), action: #selector(
        UIViewController.endiEditing))
        
        let spaceButton  = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        ////// weekTextFieldの初期化////////////////////////////////

        
        ////// textFieldの初期化////////////////////////////////////
        pickerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: pickerView.bounds.size.height)
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let vi = UIView(frame: pickerView.bounds)
        vi.backgroundColor = UIColor.white
        vi.addSubview((pickerView))
        
        textField.inputView = vi
        textField.inputAccessoryView = toolBar
        //////////////////////////////////////////////////////////////
    }
}

extension ViewController: UIPickerViewDelegate {
    //pickerの選択時の動作
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = list[row]
    }
}

extension ViewController: UIPickerViewDataSource {
    
    //pickerのコンポーネント数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //pickerの中身の表示
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    //pickerのlistの数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
}




