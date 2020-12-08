//
//  ExpansionButton.swift
//  ExpansionButtonSample
//
//  Created by 許駿 on 2020/05/07.
//  Copyright © 2020 kyo_s. All rights reserved.
//

import Foundation
import UIKit

class ExpansionButton: UIButton {
    var insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var rect = bounds
        rect.origin.x -= insets.left
        rect.origin.y -= insets.top
        rect.size.width += insets.left + insets.right
        rect.size.height += insets.top + insets.bottom

        // 拡大したViewサイズがタップ領域に含まれているかどうかを返します
        return rect.contains(point)
    }
}
