//
//  ViewController.swift
//  FirebaseSamples
//
//  Created by 許　駿 on 2020/02/28.
//  Copyright © 2020 kyo_s. All rights reserved.
//

import UIKit
import FirebaseStorage

class ViewController: UIViewController {

    @IBOutlet weak var fileNameTextField: UITextField!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var loadValue: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    func loadData(fileName: String) {
        let deviceId = UIDevice.current.identifierForVendor!.uuidString
        let storageRef = Storage.storage().reference().child("FirebaseSample/\(deviceId)/\(fileName)")

        storageRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
            guard let data = data else {
                if let error = error {
                   print(error.localizedDescription)
                }
                return
            }
        }
    }


    func saveData(fileName: String, input: String) {
        let deviceId = UIDevice.current.identifierForVendor!.uuidString

        let storageRef = Storage.storage().reference().child("FirebaseSample/\(deviceId)/\(fileName)")

        // Upload the file to the path "images/rivers.jpg"
        guard let data = input.data(using: .utf8) else {
            return
        }

        let uploadTask = storageRef.putData(data, metadata: nil) { (metadata, error) in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            print(error.debugDescription)
            return
          }
          // Metadata contains file metadata such as size, content-type.
          let size = metadata.size
          // You can also access to download URL after upload.
          storageRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              // Uh-oh, an error occurred!
              return
            }
            print(url)
          }
        }


    }
    @IBAction func saveBtnTapped(_ sender: UIButton) {

        saveData(fileName: fileNameTextField.text ?? "defaults", input: valueTextField.text ?? "")
    }

    @IBAction func loadBtnTapped(_ sender: UIButton) {
        loadData(fileName: fileNameTextField.text ?? "defaults")
    }

}

