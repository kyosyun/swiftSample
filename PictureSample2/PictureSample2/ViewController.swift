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

    var isoSlider: UISlider!
    var timerMapping: Float!
    var ssSlider: UISlider!

    // ボタンを押した時呼ばれる
    @IBAction func takeIt(_ sender: AnyObject) {
        // フラッシュとかカメラの細かな設定
        let settingsForMonitoring = AVCapturePhotoSettings()

        // フラッシュモードに関しては、ipadMiniなどでflashがそもそもない場合があり、crashするので利用に注意
        settingsForMonitoring.flashMode = .auto
        settingsForMonitoring.isAutoStillImageStabilizationEnabled = true
        settingsForMonitoring.isHighResolutionPhotoEnabled = false
        self.stillImageOutput?.capturePhoto(with: settingsForMonitoring, delegate: self)
    }

    // MARK: -- AVCaptureSessionを利用
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


                    //シャッタースピード調節スライダー
                    ssSlider = UISlider()
                    ssSlider.minimumValue = 100.0
                    ssSlider.maximumValue = 500.0
                    ssSlider.value = 100.0
                    ssSlider.translatesAutoresizingMaskIntoConstraints = false
                    ssSlider.maximumTrackTintColor = UIColor.orange
                    ssSlider.minimumTrackTintColor = UIColor.red
                    ssSlider.addTarget(self, action: #selector(ViewController.ChangeValue(sender:)), for: UIControlEvents.valueChanged)

                    self.view.addSubview(ssSlider)

                    //シャッタースピード調節スライダーの制約
                    ssSlider.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30.0).isActive = true
                    ssSlider.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -210.0).isActive = true
                    ssSlider.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
                    ssSlider.heightAnchor.constraint(equalToConstant: 30.0).isActive =  true


                    //ISO調節スライダー
                    isoSlider = UISlider()
                    isoSlider.minimumValue = 100.0
                    isoSlider.maximumValue = 520.0
                    isoSlider.value = 100.0
                    isoSlider.translatesAutoresizingMaskIntoConstraints = false
                    isoSlider.maximumTrackTintColor = UIColor.orange
                    isoSlider.minimumTrackTintColor = UIColor.red
                    isoSlider.addTarget(self, action: #selector(ViewController.ChangeValue(sender:)), for: UIControlEvents.valueChanged)

                    self.view.addSubview(isoSlider)

                    //ISO調節スライダーの制約
                    isoSlider.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30.0).isActive = true
                    isoSlider.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -150.0).isActive = true
                    isoSlider.widthAnchor.constraint(equalToConstant:250.0).isActive = true
                    isoSlider.heightAnchor.constraint(equalToConstant:30.0)

                    //ISO調節スライダーのラベル
                    let isoLabel = UILabel()
                    isoLabel.textColor = UIColor.white
                    isoLabel.layer.borderColor = UIColor.clear.cgColor
                    isoLabel.backgroundColor = UIColor.clear
                    isoLabel.translatesAutoresizingMaskIntoConstraints = false
                    isoLabel.text = "ISO"

                    self.view.addSubview(isoLabel)

                    //ISO調節スライダーのラベルの制約
                    isoLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30.0).isActive = true
                    isoLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -120.0).isActive = true
                    isoLabel.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
                    isoLabel.heightAnchor.constraint(equalToConstant: 35.0).isActive =  true

                    //ホワイトバランスONボタン
                    let wbButton = UIButton()
                    wbButton.layer.borderColor = UIColor.orange.cgColor
                    wbButton.backgroundColor = UIColor.clear
                    wbButton.layer.borderWidth = 1
                    wbButton.layer.masksToBounds = true
                    wbButton.setTitleColor(UIColor.orange, for: .normal)
                    wbButton.setTitle("WB", for: .normal)
                    wbButton.translatesAutoresizingMaskIntoConstraints = false
                    wbButton.layer.cornerRadius = 35
                    wbButton.addTarget(self, action: #selector(WB), for: .touchUpInside)
                    self.view.addSubview(wbButton)
                    //ホワイトバランスONボタンの制約
                    wbButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor , constant: 100).isActive = true
                    wbButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true
                    wbButton.widthAnchor.constraint(equalToConstant: 70.0).isActive = true
                    wbButton.heightAnchor.constraint(equalToConstant: 70.0).isActive = true


                    //ホワイトバランスOFFボタン
                    let risetButton = UIButton()
                    risetButton.layer.borderColor = UIColor.orange.cgColor
                    risetButton.backgroundColor = UIColor.clear
                    risetButton.layer.borderWidth = 1
                    risetButton.layer.masksToBounds = true
                    risetButton.setTitleColor(UIColor.orange, for: .normal)
                    risetButton.translatesAutoresizingMaskIntoConstraints = false
                    risetButton.setTitle("WB OFF", for: .normal)
                    risetButton.addTarget(self, action: #selector(risetWB), for: .touchUpInside)
                    self.view.addSubview(risetButton)
                    //ホワイトバランスOFFのボタンの制約
                    risetButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                    risetButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10.0).isActive = true
                    risetButton.widthAnchor.constraint(equalToConstant: 130.0).isActive = true
                    risetButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true

                    cameraView.layer.addSublayer(previewLayer!)
                }
            }
        }
        catch {
            print(error)
        }
    }

    //MARK: -- ISOとシャッタースピードの処理
    @objc func ChangeValue(sender: UISlider){

        let Setting = AVCaptureDevice.default(for: .video)

        do {
            try Setting?.lockForConfiguration()
            let isoSetting: Float = isoSlider.value
            timerMapping = ssSlider.value
            let StockTime: Int32 = Int32(timerMapping)
            let SetTime: CMTime = CMTimeMake(1, StockTime)
            Setting?.setExposureModeCustom(duration: SetTime, iso: isoSetting, completionHandler: nil)
            Setting?.unlockForConfiguration()
        } catch {
            let alertController = UIAlertController(title: "Cheak", message: "False !!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }

    //ホワイトバランスの処理
    @objc func WB(sender: UIButton){
        let wbSetting = AVCaptureDevice.default(for: .video)
        do{
            try wbSetting?.lockForConfiguration()
            var  g:AVCaptureDevice.WhiteBalanceGains = AVCaptureDevice.WhiteBalanceGains(redGain: 0.0, greenGain: 0.0, blueGain: 0.0)
            g.blueGain = 1.5
            g.greenGain = 1.0
            g.redGain = 4.0
            wbSetting?.setWhiteBalanceModeLocked(with: g, completionHandler: nil )
        } catch {
            let alertController = UIAlertController(title: "Cheak", message: "False !!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }

    //ホワイトバランスリセットの処理
    @objc func risetWB(sender: UIButton){
        let risetWB = AVCaptureDevice.default(for: .video)
        do{
            try risetWB?.lockForConfiguration()
            var  kaito:AVCaptureDevice.WhiteBalanceGains = AVCaptureDevice.WhiteBalanceGains(redGain: 0.0, greenGain: 0.0, blueGain: 0.0)
            kaito.blueGain = 2.5
            kaito.greenGain = 1.3
            kaito.redGain = 2.5
            risetWB?.setWhiteBalanceModeLocked(with: kaito, completionHandler: nil )
        } catch {
            let alertController = UIAlertController(title: "Cheak", message: "False !!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }


    }

    // デリゲート。カメラで撮影が完了した後呼ばれる。JPEG形式でフォトライブラリに保存。
    // MARK: -- 撮影した写真をPhotoLibraryに保存を行う
    func photoOutput(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {

        if let photoSampleBuffer = photoSampleBuffer {
            // JPEG形式で画像データを取得
            let photoData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer)
            let image = UIImage(data: photoData!)
            self.captureSesssion.stopRunning()

            let alert = UIAlertController(title: "確認", message: "この写真でよろしいですか", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "決定して次の写真へ進む", style: .default) { _ in
                // フォトライブラリに保存

                UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
                self.captureSesssion.startRunning()
            }
            let ageinAction = UIAlertAction(title: "撮影し直す", style: .default) { _ in
                self.captureSesssion.startRunning()
            }
            alert.addAction(okAction)
            alert.addAction(ageinAction)
            self.present(alert, animated: true, completion: nil)

        }
    }
}
