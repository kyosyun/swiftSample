//
//  ViewController.swift
//  QRCodeImageReader
//
//  Created by 許　駿 on 2020/01/25.
//  Copyright © 2020年 kyo_s. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var valueLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func loadQRCodeImage(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let pickerView = UIImagePickerController()
            pickerView.sourceType = .photoLibrary
            pickerView.delegate = self
            self.present(pickerView, animated: true, completion: nil)
        }
    }


    /// imageの中のQRコードを読み込んで返却する
    func readQRValFromImage(image: UIImage) -> String {

        guard let ciImage = CIImage(image: image) else {
            return "画像が見当たりませんでした。"
        }

        var message = ""

        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])


        let features = detector?.features(in: ciImage)
        for feature in features as! [CIQRCodeFeature] {
            message += feature.messageString ?? ""
        }

        return message.isEmpty ? "QRコードは検出されませんでした" : message
    }
}

extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            valueLabel.text = readQRValFromImage(image: pickedImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
