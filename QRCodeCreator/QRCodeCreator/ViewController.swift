//
//  ViewController.swift
//  QRCodeCreator
//
//  Created by 許　駿 on 2020/02/22.
//  Copyright © 2020 kyo_s. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var correctLevelSegmentedControl: UISegmentedControl!
    @IBOutlet weak var qrcodeView: UIImageView!
    @IBOutlet weak var textsizeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func editingDidEnd(_ sender: UITextField) {
        createQRCode(inputMessage: inputTextView.text!, correctionLevelString: correctLevelSegmentedControl.titleForSegment(at: correctLevelSegmentedControl.selectedSegmentIndex)!)

    }

    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        createQRCode(inputMessage: inputTextView.text!, correctionLevelString: correctLevelSegmentedControl.titleForSegment(at: correctLevelSegmentedControl.selectedSegmentIndex)!)
            textsizeLabel.text = String(inputTextView.text!.lengthOfBytes(using: .utf8))
    }


    func createQRCode(inputMessage: String, correctionLevelString: String) {
        // Data型に変換
        let inputData = inputMessage.data(using: .utf8)!
        guard let qr = CIFilter(name: "CIQRCodeGenerator", parameters: ["inputMessage": inputData, "inputCorrectionLevel": correctionLevelString]), let cgImage = qr.outputImage else {
            print("変換に失敗しました。文字数:\(inputMessage.count)")
            print("変換に失敗しました。bytes:\(inputMessage.lengthOfBytes(using: .utf8))")

            return
        }
        let sizeTransform = CGAffineTransform(scaleX: 10, y: 10)
        qrcodeView.image = UIImage(ciImage: cgImage.transformed(by: sizeTransform))
    }

}


extension UIViewController {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
