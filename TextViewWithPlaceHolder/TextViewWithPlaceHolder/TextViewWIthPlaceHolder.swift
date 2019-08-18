//
//  TextViewWIthPlaceHolder.swift
//  TextViewWithPlaceHolder
//
//  Created by 許　駿 on 2019/08/18.
//  Copyright © 2019年 kyo_s. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class TextViewWithPlaceHolder: UITextView {
    
    // プレースホルダーを設定出来る用にする
    @IBInspectable var placeHolder: String = ""
    @IBInspectable var placeHolderColor: UIColor = .lightGray

    private var placeHolderLayer: CATextLayer?

    // delegateの設定を行う
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
    }

    // layerの更新を行う
    private func updateLayer() {
        if self.text == nil || self.text.isEmpty {
            self.createPlaceHolderLayerIfNeed()
        } else {
            self.removePlaceHolderLayerIfNeed()
        }
    }
    // placeHolderを作成する
    private func createPlaceHolderLayerIfNeed() {
        let layer = CATextLayer()
        layer.fontSize = self.font?.pointSize ?? UIFont.systemFontSize
        layer.frame = CGRect(x: self.textContainerInset.left + self.textContainer.lineFragmentPadding, y: self.textContainerInset.top, width: self.frame.width, height: layer.fontSize+10)
        layer.string = self.placeHolder
        layer.foregroundColor = placeHolderColor.cgColor
        layer.contentsScale = UIScreen.main.scale
        layer.alignmentMode = CATextLayerAlignmentMode.left
        self.layer.addSublayer(layer)
        placeHolderLayer = layer
    }

    // placeHolderの削除処理
    private func removePlaceHolderLayerIfNeed() {
        placeHolderLayer?.removeFromSuperlayer()
        placeHolderLayer = nil
    }

}

extension TextViewWithPlaceHolder: UITextViewDelegate {
    // テキストが更新されたタイミングで、layerを更新する。
    func textViewDidChange(_ textView: UITextView) {
        updateLayer()
    }
}
