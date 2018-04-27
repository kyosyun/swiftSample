//
//  WeekTextPickerView.swift
//  PickerSample
//
//  Created by オフ on 2018/04/16.
//  Copyright © 2018年 kyo_s. All rights reserved.
//

import Foundation
import UIKit

class WeekTextFieldPickerView: TextFieldPickerView {
    
    //pickerの定義を行う（UIPickerViewを継承したもの）
    let weekPickerView = WeekPickerView()
    
    //delegateの宣言を行う
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        weekPickerView.weekPickerViewDelegate = self
        self.inputView = weekPickerView.getInputView()
    }
}

extension WeekTextFieldPickerView: WeekPickerViewDelegate {
    //pickerを選択した際の動作 responseに利用する値はここで定義する
    func setValueToTextField(day: String) {
        self.text = day
        self.responseVal = day
    }
}
