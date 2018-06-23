//
//  WebViewController.swift
//  sampleWebViewProject
//
//  Created by 許　駿 on 2018/06/07.
//  Copyright © 2018年 kyo_s. All rights reserved.
//

import UIKit

class WebViewController: UIViewController{

    @IBOutlet weak var webView: UIWebView!

    var urlString = Bundle.main.path(forResource: "index", ofType: "html")!

    override func viewDidLoad() {
        super.viewDidLoad()
        let html = try? String(contentsOfFile: urlString)
        webView.loadHTMLString(html!, baseURL: Bundle.main.bundleURL)
        webView.loadRequest(URLRequest(url: URL(string: "https://stg1-shiftboard.sft.x.recruit.co.jp/contact/")!))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
