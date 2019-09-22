//
//  ViewController.swift
//  CropViewControllerSample
//
//  Created by 許　駿 on 2019/09/22.
//  Copyright © 2019年 kyo_s. All rights reserved.
//

import UIKit
import CropViewController

class ViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func openImageView(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // 写真を選ぶビュー
            let pickerView = UIImagePickerController()
            // 写真の選択元をカメラロールにする
            // 「.camera」にすればカメラを起動できる
            pickerView.sourceType = .photoLibrary
            // デリゲート
            pickerView.delegate = self
            // ビューに表示
            self.present(pickerView, animated: true)
        }
    }


    @IBAction func openCropView(_ sender: UIButton) {
        guard let image = imageView.image else {
            return
        }
        let cropViewController = CropViewController(image: image)
        cropViewController.delegate = self
        self.present(cropViewController, animated: true, completion: nil)
    }

}

extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            imageView.image = pickedImage

        }
        picker.dismiss(animated: true, completion: nil)
    }
}

extension UIViewController: CropViewControllerDelegate {

    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        //加工した画像が取得できる
    }

    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
        // キャンセル時
        cropViewController.dismiss(animated: true, completion: nil)
    }
}
