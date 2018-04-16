//
//  TextFieldPickerView.swift
//  PickerSample
//
//  Created by オフ on 2018/04/16.
//  Copyright © 2018年 kyo_s. All rights reserved.
//

import Foundation
import UIKit

class TextFieldPickerView: UITextField {
    
    var responseVal: String?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.inputAccessoryView = createToolBar()
    }
    
    func createToolBar() -> UIView {
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
        return toolBar
    }
}
