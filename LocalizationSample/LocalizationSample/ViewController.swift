//
//  ViewController.swift
//  LocalizationSample
//
//  Created by 許　駿 on 2019/12/12.
//  Copyright © 2019年 kyo_s. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var localizedString: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var editableTextField: UITextField!
    @IBOutlet weak var editableText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setText()
    }

    // MARK: 言語に対応したテキスト・画像の呼び出し
    func setText() {
        localizedString.text = NSLocalizedString("LocalizationStringKey", comment: "comment")
        img.image = UIImage(named: NSLocalizedString("img", comment: ""))
    }

    // MARK: 端末言語を上書きする
    @IBAction func enTapped(_ sender: UIButton) {
        UserDefaults.standard.setValue(["en"], forKey: "AppleLanguages")
        print(UserDefaults.standard.object(forKey: "AppleLanguages") ?? "")
        localizedString.text = NSLocalizedString(key: "LocalizationStringKey", comment: "", languageCode: "en")
    }

    @IBAction func jaTapped(_ sender: UIButton) {
        UserDefaults.standard.setValue(["ja"], forKey: "AppleLanguages")
        print(UserDefaults.standard.object(forKey: "AppleLanguages") ?? "")
        localizedString.text = NSLocalizedString(key: "LocalizationStringKey", comment: "", languageCode: "ja")
    }

    @IBAction func editTapped(_ sender: UIButton) {
        UserDefaults.standard.set(editableTextField.text ?? "", forKey: "editableText")
        print(UserDefaults.standard.string(forKey: "editableText") ?? "")
    }

}

