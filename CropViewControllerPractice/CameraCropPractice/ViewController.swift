//
//  ViewController.swift
//  CameraCropPractice
//
//  Created by Keisei Saito on 2017/10/11.
//  Copyright © 2017 Keisei Saito. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, CropViewControllerDelegate {
    @IBOutlet var cameraView: UIImageView!
    @IBOutlet var label: UILabel!
    
    @IBAction func start(_ sender: AnyObject) {
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "カメラから", style: .default) { [weak self] _ in
            self?.startCamera()
        })
        ac.addAction(UIAlertAction(title: "ライブラリから", style: .default) { [weak self] _ in
            self?.openPhotoLibrary()
        })
        ac.addAction(UIAlertAction(title: "キャンセル", style: .cancel))
        self.present(ac, animated: true)
    }

    private func startCamera() {
        let sourceType: UIImagePickerControllerSourceType = .camera
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        } else {
            label.text = "error"
        }
    }

    private func openPhotoLibrary() {
        let sourceType: UIImagePickerControllerSourceType = .photoLibrary
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            label.text = "Tap the [Start] to save a picture"
        } else {
            label.text = "error"
        }
    }

    // MARK: - CropViewControllerDelegate

    func cropViewControllerDidFinishTask(_ image: UIImage) {
        cameraView.contentMode = .scaleAspectFit
        cameraView.image = image
        label.text = "Cropped!"
    }
}

// MARK: - UIImagePickerControllerDelegate

extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        guard let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        cameraView.contentMode = .scaleAspectFit
        cameraView.image = pickedImage
        imagePicker.dismiss(animated: true, completion: nil)
        let vc: CropViewController = CropViewController.instantiateFromStoryboard()
        vc.delegate = self
        vc.prepareView(image: pickedImage)
        self.present(vc, animated: true)
        label.text = "Tap the [Save] to save a picture"
    }
}
