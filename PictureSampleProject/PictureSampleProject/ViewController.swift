//
//  ViewController.swift
//  PictureSampleProject
//
//  Created by 許　駿 on 2018/04/28.
//  Copyright © 2018年 kyo_s. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var imageName: UITextField!
    @IBOutlet weak var imageSizeLabel: UILabel!
    @IBOutlet weak var resultImageSizeLabel: UILabel!

    @IBOutlet weak var loadImageButton: UIButton!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: -- カメラロールから写真の読み込み
    @IBAction func selectPhotoFromLibrary(_ sender: UIButton) {
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

    // MARK: -- カメラからの写真の読み込み。
    @IBAction func selectPhotoFromCamera(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // 写真を選ぶビュー
            let pickerView = UIImagePickerController()
            // 写真の選択元をカメラロールにする
            // 「.camera」にすればカメラを起動できる
            pickerView.sourceType = .camera
            // デリゲート
            pickerView.delegate = self
            // ビューに表示
            self.present(pickerView, animated: true)
        }
    }

    //MARK: -- 写真をローカルのディレクトリに保存する
    @IBAction func savePhotoToLocalDirectory(_ sender: UIButton) {
        guard let image = imageView.image else {
            let vc = createSimpleAlertDialg(title: "確認", message: "imageを選択してください")
            self.present(vc, animated: true, completion: nil)
            return
        }

        guard let imageName = imageName.text, imageName != "" else {
            let vc = createSimpleAlertDialg(title: "確認", message: "image名を入力してください")
            self.present(vc, animated: true, completion: nil)
            return
        }

        if let data = UIImagePNGRepresentation(image) {
            // ディレクトリにファイル名を追加する
            let filename = getDocumentsDirectory().appendingPathComponent(imageName)
            try? data.write(to: filename)
        }
    }

    // ファイルを保存するディレクトリを取得
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    //MARK: -- 写真をローカルディレクトリから読み込む
    @IBAction func locadPhotoFromLocalDirectory(_ sender: UIButton) {
        guard let imageName = imageName.text, imageName != "" else {
            let vc = createSimpleAlertDialg(title: "確認", message: "image名を入力してください")
            self.present(vc, animated: true, completion: nil)
            return
        }

        let filename = getDocumentsDirectory().appendingPathComponent(imageName)
        resultImageView.image = UIImage(contentsOfFile: filename.path)
        resultImageSizeLabel.text = getSizeOfUIImage(image: resultImageView.image!)
    }

    //MARK: -- 表示している写真を圧縮する
    @IBAction func resizePhoto(_ sender: UIButton) {
        guard let image = imageView.image else {
            self.present(createSimpleAlertDialg(title: "確認", message: "imageを選択してください"), animated: true)
            return
        }
        let resizeSize = CGSize(width: image.size.width / 5 , height: image.size.height / 5)
        resultImageView.image = resize(image: image, size: resizeSize)
        resultImageSizeLabel.text = getSizeOfUIImage(image: resultImageView.image!)
    }

    func resize(image: UIImage, size _size: CGSize) -> UIImage? {
        let widthRatio = _size.width / image.size.width
        let heightRatio = _size.height / image.size.height
        let ratio = widthRatio < heightRatio ? widthRatio : heightRatio

        let resizedSize = CGSize(width: image.size.width * ratio, height: image.size.height * ratio)

        UIGraphicsBeginImageContext(resizedSize)
        image.draw(in: CGRect(origin: .zero, size: resizedSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resizedImage
    }

    //MARK: -- UIImageの容量を取得する
    func getSizeOfUIImage(image: UIImage) -> String {
        if let data = UIImagePNGRepresentation(image) {
            // ディレクトリにファイル名を追加する
            let filename = getDocumentsDirectory().appendingPathComponent("fileNameForGetSizeOfUIImage.png")
            try? data.write(to: filename)
            do {
                let attributes = try FileManager.default.attributesOfItem(atPath: filename.path)
                return "\(attributes[.size] ?? 0)"
            } catch {
                print("error")
            }
        }
        return "0"
    }

}

extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = pickedImage
            imageSizeLabel.text = getSizeOfUIImage(image: pickedImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: -- util
extension ViewController {
    func createSimpleAlertDialg(title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        return alertController
    }
}
