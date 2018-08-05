//
//  NSObject.swift
//  navigationSample
//
//  Created by 許　駿 on 2018/08/05.
//  Copyright © 2018年 kyo_s. All rights reserved.
//

import UIKit

extension NSObject {

    class var className: String{
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }

}

