//
//  UIViewController+Extension.swift
//  CameraCropPractice
//
//  Created by Keisei Saito on 2017/10/11.
//  Copyright © 2017 Keisei Saito. All rights reserved.
//

import UIKit

extension UIViewController {
    class func instantiateFromStoryboard<T: UIViewController>() -> T {
        let storyboard = UIStoryboard(name: T.className, bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! T
        return vc
    }
}
