//
//  ViewController.swift
//  sandbox2
//
//  Created by 許駿 on 2020/10/03.
//  Copyright © 2020 kyo_s. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    override func viewDidLoad() {
         super.viewDidLoad()
         // Do any additional setup after loading the view.
         initAVPlayer()
     }

     var player: AVPlayer?
     var playerLayer: AVPlayerLayer?
     
     func initAVPlayer() {
         player = AVPlayer(url: URL(fileURLWithPath: "file:///private/var/mobile/Containers/Data/PluginKitPlugin/FC123D19-DD1E-4272-BCF3-EF865E27BBFC/tmp/trim.04424CB2-BCDE-497A-8F6C-0B969291A072.MOV"))
         playerLayer = AVPlayerLayer(player: player)
         playerLayer?.frame = self.view.bounds
         // videoのサイズ
         playerLayer?.videoGravity = .resizeAspect
         // layerのZポジション
         playerLayer?.zPosition = -1
         self.view.layer.insertSublayer(playerLayer!, at: 0)
     }

}

