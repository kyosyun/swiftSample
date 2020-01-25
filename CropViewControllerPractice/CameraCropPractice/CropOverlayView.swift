//
//  CropOverlayView.swift
//  CameraCropPractice
//
//  Created by Keisei Saito on 2017/10/12.
//  Copyright © 2017 Keisei Saito. All rights reserved.
//

import UIKit

class CropOverlayView: UIView {
    init() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height

        super.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))

        isUserInteractionEnabled = false

        let overlayViewHeight = (screenHeight - screenWidth) / 2

        let upper = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: overlayViewHeight))
        let lower = UIView(frame: CGRect(x: 0, y: screenWidth + overlayViewHeight, width: screenWidth, height: overlayViewHeight))

        upper.isUserInteractionEnabled = false
        lower.isUserInteractionEnabled = false

        upper.backgroundColor = UIColor.ex.cropViewOverlay
        lower.backgroundColor = UIColor.ex.cropViewOverlay

        addSubview(upper)
        addSubview(lower)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
