//
//  ViewController.swift
//  sampleWebViewProject
//
//  Created by 許　駿 on 2018/05/03.
//  Copyright © 2018年 kyo_s. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {


    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var nameTextField: UITextField!

    //外部URLへのアクセス
//    var url = URLRequest(url: URL(string: "https://developer.apple.com/")!)
    //内部リソースへのアクセス
    var urlString = Bundle.main.path(forResource: "index", ofType: "html")!
    var image = #imageLiteral(resourceName: "SamplePic.png")
    var imageName = "assessmentPicture.png"

    override func viewDidLoad() {
        super.viewDidLoad()
        loadAddressURL()
        saveImage(image: image, path: fileInDocumentsDirectory(fileName: imageName))

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func saveImage() {
        let pngImageData = UIImagePNGRepresentation(image)
        let savePath = Bundle.main.bundlePath + "/temp/res.png"
        let saveUrl = URL(string: savePath)
        let result = try? pngImageData?.write(to: saveUrl!, options: Data.WritingOptions.atomic)
    }

    func saveImage(image: UIImage, path: URL) {
        let pngImageData = UIImagePNGRepresentation(image)
        try? pngImageData?.write(to: path)
    }

    func loadAddressURL() {
        //ローカルのHTMLへのアクセスを行う
        let html = try? String(contentsOfFile: urlString)
        webView.loadHTMLString(html!, baseURL: Bundle.main.bundleURL)
    }

    func getDocumentsURL() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    func fileInDocumentsDirectory(fileName: String) -> URL {
        return getDocumentsURL().appendingPathComponent(fileName)
    }

    @IBAction func btnTapped(_ sender: UIButton) {
        webView.evaluateJavaScript("window.test()", completionHandler: nil)
    }

    @IBAction func hello(_ sender: UIButton) {
        webView.evaluateJavaScript("window.hello('\(nameTextField.text!)')", completionHandler: nil)
    }

    @IBAction func setImage(_ sender: UIButton) {
        let savePath = fileInDocumentsDirectory(fileName: imageName).path
        webView.evaluateJavaScript("window.setImage('\(savePath)')", completionHandler: nil)
    }
}

