//
//  ViewController.swift
//  iCloudDocuments
//
//  Created by 許　駿 on 2020/02/22.
//  Copyright © 2020 kyo_s. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!

    private var icloudContainerURL: URL? {
        let url = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("kyo-s.iCloudDocuments")
        do {
            try FileManager.default.createDirectory(at: url!, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            // エラー
        }
        return url
    }

    private var documentURL: URL {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return URL(fileURLWithPath: documentPath + "/documentSaveTest.txt")
    }

    private var fileNames: [String]! = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func save(_ sender: UIButton) {
        save(data: textView.text!.data(using: .utf8)!)
    }

    @IBAction func documentSave(_ sender: UIButton) {
        documentSave(data: textView.text!.data(using: .utf8)!)
    }

    @IBAction func documentLoad(_ sender: UIButton) {
        guard let data = documentLoad() else {
            print("データのロードに失敗")
            return
        }
        textView.text = String(data: data, encoding: .utf8)
    }

    @IBAction func load(_ sender: UIButton) {
        guard let data = load() else {
            print("データのロードに失敗")
            return
        }
        textView.text = String(data: data, encoding: .utf8)
    }

    func save(data: Data) {
        let fileURL = icloudContainerURL?.appendingPathComponent("sample.txt")
        do {
            try data.write(to: fileURL!, options: Data.WritingOptions.atomic)
        } catch let error as NSError{
            // エラー処理
        }
    }
    func documentSave(data: Data) {
        do {
            try data.write(to: documentURL)
        } catch let error as NSError{
            // エラー処理
        }
    }

    func load() -> Data? {
        // 指定したディレクトリ内のファイル名を全て取得する
        do {
            fileNames = try FileManager.default.contentsOfDirectory(atPath: (icloudContainerURL?.path)!)
            let filePath = icloudContainerURL?.appendingPathComponent("\(fileNames[0])")
            return try Data(contentsOf: filePath!)
        } catch let error as NSError{
            // エラー処理
        }
        return nil
    }

    func documentLoad() -> Data? {
        return FileManager.default.contents(atPath: documentURL.path)
    }
}

extension UIViewController {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

