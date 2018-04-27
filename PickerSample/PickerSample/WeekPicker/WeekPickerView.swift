//
//  WeekPickerView.swift
//  PickerSample
//
//  Created by オフ on 2018/04/15.
//  Copyright © 2018年 kyo_s. All rights reserved.
//

import Foundation
import UIKit

class WeekPickerView: UIPickerView {
    
    weak var weekPickerViewDelegate: WeekPickerViewDelegate?
 
    var week = ["mon", "tue", "wed", "thu", "fri", "sat", "sun"]
    
    init() {
        super.init(frame: CGRect())
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height:self.bounds.size.height)
        self.dataSource = self
        self.delegate = self
        let weekVi = UIView(frame: self.bounds)
        weekVi.backgroundColor = UIColor.white
        weekVi.addSubview(self)
    }
    
    func getInputView() -> UIView {
        let weekVi = UIView(frame: self.bounds)
        weekVi.backgroundColor = UIColor.white
        weekVi.addSubview(self)
        return weekVi
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

extension WeekPickerView: UIPickerViewDelegate {
    //pickerの選択時の動作
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        weekPickerViewDelegate?.setValueToTextField(day: week[row])
    }
    
}

protocol WeekPickerViewDelegate: class {
    func setValueToTextField(day: String)
}

extension WeekPickerView: UIPickerViewDataSource {
    
    //pickerのコンポーネント数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //pickerの中身の表示
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return week[row]
    }
    
    //pickerのlistの数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return week.count
    }
}
