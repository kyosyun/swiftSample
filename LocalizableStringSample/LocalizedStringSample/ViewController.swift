//
//  ViewController.swift
//  LocalizedStringSample
//
//  Created by 許　駿 on 2020/01/05.
//  Copyright © 2020年 kyo_s. All rights reserved.
//

import UIKit

/*
 [x] 起動中に言語切替:NSLocalizedStringのOverride <br>
 [x] stringの便利extention <br>
 [x] viewの再読み込み <br>
 [x] swiftgenを利用する
 */

class ViewController: UIViewController {

    @IBOutlet weak var deviceLangLabel: UILabel!
    @IBOutlet weak var langSettingLabel: UILabel!
    @IBOutlet weak var enBtn: UIButton!
    @IBOutlet weak var jaBtn: UIButton!
    @IBOutlet weak var frBtn: UIButton!
    @IBOutlet weak var refreshBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setText()

    }

    func setText() {
        let lang = AppEnvironment.shared.lang.rawValue
        deviceLangLabel.text = L10n.deviceSetting(lang).tr()
        langSettingLabel.text = L10n.langSetting.tr()
        enBtn.setTitle(L10n.Lang.en.tr(), for: .normal)
        jaBtn.setTitle(L10n.Lang.ja.tr(), for: .normal)
        refreshBtn.setTitle(L10n.reloadScreen.tr(), for: .normal)
    }

    // MARK: - 起動中に言語切替
    @IBAction func enBtnTapped(_ sender: UIButton) {
        AppEnvironment.shared.lang = Lang.EN
    }

    @IBAction func jaBtnTapped(_ sender: UIButton) {
        AppEnvironment.shared.lang = Lang.JA
    }

    // MARK: - どの言語にも一致しない場合は、Localization native development regionの設定を読み込む
    @IBAction func frBtnTapped(_ sender: UIButton) {
        AppEnvironment.shared.lang = Lang.FR
    }

    // MARK: - 画面の再読み込み
    @IBAction func refreshBtnTapped(_ sender: UIButton) {
        loadView()
        viewDidLoad()
    }

}

