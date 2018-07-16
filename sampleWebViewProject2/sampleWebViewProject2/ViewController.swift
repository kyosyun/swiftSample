//
//  ViewController.swift
//  sampleWebViewProject2
//
//  Created by 許　駿 on 2018/07/15.
//  Copyright © 2018年 kyo_s. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var nameTextField: UITextField!
    var image = #imageLiteral(resourceName: "SamplePic")
//    var saveUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("assessmentPicture.png")
    var saveUrl = Bundle.main.bundleURL.appendingPathComponent("assessmentPicture.png")

    override func viewDidLoad() {
        let html = try? String(contentsOfFile: Bundle.main.path(forResource: "index", ofType: "html")!)
//        let baseUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let baseUrl = Bundle.main.bundleURL.appendingPathComponent("assessmentPicture.png")
        webView.loadHTMLString(html!, baseURL: baseUrl)
        print("baseUrl: \(baseUrl)")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func saveImage(_ sender: UIButton) {
        let pngImageData = UIImagePNGRepresentation(image)
        try? pngImageData?.write(to: saveUrl, options: Data.WritingOptions.atomic)
        print("saveUrl: \(saveUrl.absoluteString)")
    }

    @IBAction func changeText(_ sender: UIButton) {
        webView.evaluateJavaScript("window.hello('\(nameTextField.text!)')", completionHandler: nil)
    }

    @IBAction func setImage(_ sender: UIButton) {
//        webView.evaluateJavaScript("window.setImage('\(saveUrl.path)')", completionHandler: nil)
//        webView.evaluateJavaScript("window.setImage('\(saveUrl.path)')", completionHandler: nil)
        webView.evaluateJavaScript("window.setImage('data:image/png;base64,\(base64Encode(image: image))')", completionHandler: nil)
        print("loadImagePath: \(saveUrl.path)")
    }

    func base64Encode(image: UIImage) -> String {
        let imageData = UIImageJPEGRepresentation(image, 1)
        // オプション無し
        let base64EncodedImage = imageData?.base64EncodedString() ?? "" // aG9nZQ==
        return base64EncodedImage
    }


}

