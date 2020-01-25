//
//  ViewController.swift
//  AVPlayerSample
//
//  Created by 許　駿 on 2020/01/25.
//  Copyright © 2020年 kyo_s. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVPlayer?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        prepareAVPlayer()
    }


    func prepareAVPlayer() {
        guard let url = URL(string: "https://movie-labo.info/sample/whitecat320.mp4") else {
            return
        }
        player = AVPlayer(url: url)

        // 再生する
        player?.play()

        // layer作成
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        // videoのサイズ
        playerLayer.videoGravity = .resizeAspect
        // layerのZポジション
        playerLayer.zPosition = -1
        view.layer.insertSublayer(playerLayer, at: 0)
    }

    @IBAction func restart(_ sender: UIButton) {
        // restartする
        player?.seek(to: CMTime.zero)
        player?.play()
    }

}

