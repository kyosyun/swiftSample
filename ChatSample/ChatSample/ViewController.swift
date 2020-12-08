//
//  ViewController.swift
//  ChatSample
//
//  Created by 許駿 on 2020/05/05.
//  Copyright © 2020 kyo_s. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController {
    
    
    
    var databaseRef: DatabaseReference!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var nameInputView: UITextField!
    @IBOutlet weak var messageInputView: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        databaseRef = Database.database().reference()
        
        databaseRef.child("charoom1").observe(.childAdded, with: { snapshot in
            if let message = snapshot.value as? Message  {
                self.textView.text = (self.textView.text ?? "") + "\n\(message.name) : \(message.message)"
            }
        })
    }
    
    @IBAction func tappedSendButton(_ sender: UIButton) {
        view.endEditing(true)

        if let name = nameInputView.text, let message = messageInputView.text {
            let messageObj = Message(name: name, message: message)
            databaseRef.child("charoom1").childByAutoId().setValue(try? JSONEncoder().encode(messageObj))
            messageInputView.text = ""
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

struct Message: Codable {
    let name: String
    let message: String
}
