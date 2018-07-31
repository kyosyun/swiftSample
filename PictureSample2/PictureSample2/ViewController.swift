//
//  ViewController.swift
//  PictureSample2
//
//  Created by 許　駿 on 2018/08/01.
//  Copyright © 2018年 kyo_s. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController ,AVCapturePhotoCaptureDelegate {
    // カメラの映像をここに表示
    @IBOutlet weak var cameraView: UIView!

    var captureSesssion: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // ボタンを押した時呼ばれる
    @IBAction func takeIt(_ sender: AnyObject) {
        // フラッシュとかカメラの細かな設定
        let settingsForMonitoring = AVCapturePhotoSettings()
        settingsForMonitoring.flashMode = .auto
        settingsForMonitoring.isAutoStillImageStabilizationEnabled = true
        settingsForMonitoring.isHighResolutionPhotoEnabled = false
        // シャッターを切る
        stillImageOutput?.capturePhoto(with: settingsForMonitoring, delegate: self)
    }

    override func viewDidAppear(_ animated: Bool) {

        captureSesssion = AVCaptureSession()
        stillImageOutput = AVCapturePhotoOutput()

        captureSesssion.sessionPreset = AVCaptureSession.Preset.photo // 解像度の設定

        let device = AVCaptureDevice.default(for: AVMediaType.video)

        do {
            let input = try AVCaptureDeviceInput(device: device!)

            // 入力
            if (captureSesssion.canAddInput(input)) {
                captureSesssion.addInput(input)

                guard let stillImageOutput = stillImageOutput else {return}

                // 出力
                if (captureSesssion.canAddOutput(stillImageOutput)) {
                    captureSesssion.addOutput(stillImageOutput)
                    captureSesssion.startRunning() // カメラ起動

                    previewLayer = AVCaptureVideoPreviewLayer(session: captureSesssion)
                    // ビューのサイズの調整
                    previewLayer?.frame = UIScreen.main.bounds
                    previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
                    previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait // カメラの向き

                    cameraView.layer.addSublayer(previewLayer!)
                }
            }
        }
        catch {
            print(error)
        }
    }
    // デリゲート。カメラで撮影が完了した後呼ばれる。JPEG形式でフォトライブラリに保存。
    func photoOutput(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {

        if let photoSampleBuffer = photoSampleBuffer {
            // JPEG形式で画像データを取得
            let photoData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer)
            let image = UIImage(data: photoData!)

            // フォトライブラリに保存
            UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        }
    }
}
