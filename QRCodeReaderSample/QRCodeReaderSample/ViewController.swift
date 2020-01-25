//
//  ViewController.swift
//  QRCodeReaderSample
//
//  Created by 許　駿 on 2020/01/25.
//  Copyright © 2020年 kyo_s. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var textLabel: UILabel!

    var videoLayer: AVCaptureVideoPreviewLayer?

    let captureSession = AVCaptureSession()

    /// QRコードを囲む用のView
    var qrBorderView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareQrBorderView()
        prepareAVCaptureVideo()
    }

    func prepareQrBorderView() {
        qrBorderView = UIView()
        qrBorderView.layer.borderWidth = 4
        qrBorderView.layer.borderColor = UIColor.blue.cgColor
        qrBorderView.layer.zPosition = 1
        qrBorderView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        previewView.layer.addSublayer(qrBorderView.layer)
    }


    func prepareAVCaptureVideo() {
        // 入力データ
        guard let videoDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        let videoInput = try! AVCaptureDeviceInput.init(device: videoDevice)
        captureSession.addInput(videoInput)


        // 出力データ
        let metadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(metadataOutput)

        // QRコードを検出した際のでDelegate設定
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        metadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]


        // プレビュー表示
        videoLayer = AVCaptureVideoPreviewLayer.init(session: captureSession)
        videoLayer?.frame = previewView.bounds
        videoLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewView.layer.addSublayer(videoLayer!)

        // セッション開始
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
    }

}


extension ViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        for metadata in metadataObjects as! [AVMetadataMachineReadableCodeObject] {
            if metadata.type == .qr {
                let barCode = videoLayer?.transformedMetadataObject(for: metadata) as! AVMetadataMachineReadableCodeObject
                qrBorderView.frame = barCode.bounds
            
                textLabel.text = metadata.stringValue
            }
        }
    }
}
