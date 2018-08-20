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
    var image = #imageLiteral(resourceName: "SamplePic")

    override func viewDidLoad() {
        //ローカルのHTMLの読み込み
        let html = try? String(contentsOfFile: Bundle.main.path(forResource: "index", ofType: "html")!)
        let baseUrl = Bundle.main.bundleURL.appendingPathComponent("assessmentPicture.png")
        webView.loadHTMLString(html!, baseURL: baseUrl)

        super.viewDidLoad()
    }

    // MARK: -- UIImageをBASE64Encodeして、WebViewに受け渡す
    @IBAction func setImage(_ sender: UIButton) {
        webView.evaluateJavaScript("window.setImage('data:image/png;base64,\(base64Encode(image: image))')", completionHandler: nil)
    }

    func base64Encode(image: UIImage) -> String {
        let imageData = UIImageJPEGRepresentation(image, 1)
        // オプション無し
        let base64EncodedImage = imageData?.base64EncodedString() ?? "" // aG9nZQ==
        return base64EncodedImage
    }


}

