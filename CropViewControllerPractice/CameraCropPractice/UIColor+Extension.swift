//
//  UIColor+Extension.swift
//  CameraCropPractice
//
//  Created by Keisei Saito on 2017/10/12.
//  Copyright © 2017 Keisei Saito. All rights reserved.
//

import UIKit

extension UIColor: ExtensionCompatible {}

extension Extension where Base: UIColor {
    static var cropViewOverlay: UIColor {
        return UIColor(white: 0, alpha: 0.5)
    }
}
