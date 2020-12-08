//
//  ViewController.swift
//  DontNotice
//
//  Created by 許駿 on 2020/04/20.
//  Copyright © 2020 kyo_s. All rights reserved.
//

import Cocoa
import SystemConfiguration

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func btnTap(_ sender: NSButton) {
        
        //デフォルトのシステム設定(SCPreferences)を取得する
        let prefs = SCPreferencesCreate(nil, "process-name" as CFString, nil)!
        //システム設定から[SCNetworkSet]を取得する
        if let sets = SCNetworkSetCopyAll(prefs) as? [SCNetworkSet] {
            for set in sets {
                //SCNetworkSetからユーザ定義名称を取得する
                let userDefinedName = SCNetworkSetGetName(set) as String?
                print(userDefinedName ?? "*no name*")
            }
        } else {
            print("cannot get [SCNetworkSet] from this preference: \(prefs)")
        }
    }
    
}

