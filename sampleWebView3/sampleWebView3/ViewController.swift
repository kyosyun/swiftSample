//
//  ViewController.swift
//  sampleWebView3
//
//  Created by 許　駿 on 2018/08/21.
//  Copyright © 2018年 kyo_s. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var greetingLabel: UILabel!

    override func viewDidLoad() {

        super.viewDidLoad()

        let webConfig: WKWebViewConfiguration = WKWebViewConfiguration()
        let userController: WKUserContentController = WKUserContentController()

        // フックするアクション名を指定する
        userController.add(self, name: "hoge")
        webConfig.userContentController = userController

        // WebViewの生成
        let wkWebView = WKWebView(frame: self.view.frame, configuration: webConfig)
        let html = try? String(contentsOfFile: Bundle.main.path(forResource: "index", ofType: "html")!)
        wkWebView.loadHTMLString(html!, baseURL: Bundle.main.bundleURL)
        self.view.addSubview(wkWebView)
    }
}

//MARK: -- WebView内で発火したアクションをキャッチする
extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "hoge" {
            print("fuga")
        }
    }
}
