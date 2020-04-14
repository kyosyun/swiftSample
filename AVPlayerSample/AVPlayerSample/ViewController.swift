//
//  ViewController.swift
//  AVPlayerSample
//
//  Created by 許　駿 on 2020/01/25.
//  Copyright © 2020年 kyo_s. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UINavigationControllerDelegate {

    let imagePickerController = UIImagePickerController()
    var videoURL: URL?
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?

    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var previewView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        prepareAVPlayer()
    }


    func prepareAVPlayer() {
        // layer作成
        guard let videoURL = videoURL else {return}
        player = AVPlayer(url: videoURL)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = previewView.bounds
        // videoのサイズ
        playerLayer?.videoGravity = .resizeAspect
        // layerのZポジション
        playerLayer?.zPosition = -1
        previewView.layer.insertSublayer(playerLayer!, at: 0)
    }

    @IBAction func restart(_ sender: UIButton) {
        previewView.layer.sublayers?.removeAll()
        prepareAVPlayer()
        // 再生する
        player?.play()
        // restartする
        player?.seek(to: CMTime.zero)
        player?.play()
    }

    @IBAction func selectMove(_ sender: UIButton) {
        //動画だけを抽出
        imagePickerController.mediaTypes = ["public.movie"]
        present(imagePickerController, animated: true, completion: nil)
    }

    func previewImageFromVideo(_ url:URL) -> UIImage? {
        let asset = AVAsset(url:url)
        let imageGenerator = AVAssetImageGenerator(asset:asset)
        imageGenerator.appliesPreferredTrackTransform = true
        var time = asset.duration
        time.value = min(time.value,2)
        do {
            let imageRef = try imageGenerator.copyCGImage(at: time, actualTime: nil)
            return UIImage(cgImage: imageRef)
        } catch {
            return nil
        }
    }
}


extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.videoURL = info[.mediaURL] as? URL
        print(videoURL!)
        let imageView = UIImageView()
        imageView.image = previewImageFromVideo(videoURL!)!
        imageView.contentMode = .scaleAspectFit
        imageView.frame = self.previewView.frame
        self.previewView.layer.addSublayer(imageView.layer)
        imagePickerController.dismiss(animated: true, completion: nil)
    }
}
