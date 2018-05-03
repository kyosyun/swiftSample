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

    var url = URLRequest(url: URL(string: "https://developer.apple.com/")!)

    override func viewDidLoad() {
        super.viewDidLoad()
        loadAddressURL()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func loadAddressURL() {
        webView.load(url)
    }
}

