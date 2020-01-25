//
//  NSObject+Extension.swift
//  CameraCropPractice
//
//  Created by Keisei Saito on 2017/10/11.
//  Copyright © 2017 Keisei Saito. All rights reserved.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
