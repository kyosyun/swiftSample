//
//  PaintImageView.swift
//  PaintSample
//
//  Created by 許　駿 on 2018/04/30.
//  Copyright © 2018年 kyo_s. All rights reserved.
//

import UIKit



class PaintImageView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    var strokeWidth: CGFloat = 10.0

    private var tapedPoint: CGPoint = CGPoint()

    private var originalImage: UIImage = UIImage()

    func initialize() {
        self.isUserInteractionEnabled = true

        guard let image = self.image else {
            self.addObserver(self, forKeyPath: "image", options: .new, context: nil)
            return
        }

        self.originalImage = image

    }

    override init(image: UIImage?) {
        super.init(image: image)
        initialize()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    //タップが始まったときの動作
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            tapedPoint = touch.location(in: self)
            addMark(to: tapedPoint)
        }
    }

    //ドラッグ中の動作
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let endPoint = touch.location(in: self)
            //draw(endPoint: endPoint)
            addMark(to: endPoint)
        }
    }

    //タップが終わったときの動作
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //clear()
    }

    func addMark(to: CGPoint) {
        let text = "A"
        let font = UIFont.boldSystemFont(ofSize: 20)

        let rect = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)

        // Context 開始
        UIGraphicsBeginImageContext((self.frame.size))
        UIGraphicsBeginImageContextWithOptions((self.frame.size), false, 0)
        image?.draw(in: rect)

        let textStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle

        let textFontAttributes = [
            NSAttributedStringKey.font: font,
            NSAttributedStringKey.foregroundColor: UIColor.yellow,
            NSAttributedStringKey.paragraphStyle: textStyle
        ]


        text.draw(at: tapedPoint, withAttributes: textFontAttributes)

        self.image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

    }

    //初期化のためのコード
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "image" {
            originalImage = change![NSKeyValueChangeKey(rawValue: keyPath!)] as! UIImage

            self.removeObserver(self, forKeyPath: "image")
        }
    }

    func draw(endPoint: CGPoint) {
        UIGraphicsBeginImageContext(self.frame.size)

        self.image?.draw(in: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))

        UIGraphicsGetCurrentContext()!.setLineWidth(strokeWidth)
        UIGraphicsGetCurrentContext()!.setStrokeColor(red: 1.0, green: 0, blue: 0, alpha: 1.0)

        UIGraphicsGetCurrentContext()!.setLineCap(.round)

        UIGraphicsGetCurrentContext()?.move(to: tapedPoint)
        UIGraphicsGetCurrentContext()?.addLine(to: endPoint)

        UIGraphicsGetCurrentContext()?.strokePath()

        self.image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        tapedPoint = endPoint

    }

    func clear() {
        self.image = nil
        self.image = originalImage
    }
}
