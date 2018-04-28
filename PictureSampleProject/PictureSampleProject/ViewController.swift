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


    @IBOutlet weak var loadImageButton: UIButton!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sampleButtonTapped(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {

            let picker = UIImagePickerController()
            picker.modalPresentationStyle = UIModalPresentationStyle.popover
            picker.delegate = self // UINavigationControllerDelegate と　UIImagePickerControllerDelegateを実装する
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary

            if let popover = picker.popoverPresentationController {
                popover.sourceView = self.view
                popover.sourceRect = loadImageButton.frame // ポップオーバーの表示元となるエリア
                popover.permittedArrowDirections = UIPopoverArrowDirection.any
            }
            self.present(picker, animated: true, completion: nil)
        }
    }

    @IBAction func sampleButton2Tapped(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {

            let picker = UIImagePickerController()
            picker.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            picker.delegate = self // UINavigationControllerDelegate と　UIImagePickerControllerDelegateを実装する
            picker.sourceType = UIImagePickerControllerSourceType.camera

            self.present(picker, animated: true, completion: nil)
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
