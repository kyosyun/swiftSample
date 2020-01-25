//
//  CropScrollView.swift
//  CameraCropPractice
//
//  Created by Keisei Saito on 2017/10/12.
//  Copyright © 2017 Keisei Saito. All rights reserved.
//

import UIKit

class CropScrollView: UIScrollView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .black
        clipsToBounds = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
