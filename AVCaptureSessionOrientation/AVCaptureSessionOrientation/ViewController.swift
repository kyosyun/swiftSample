//
//  ViewController.swift
//  AVCaptureSessionOrientation
//
//  Created by 許駿 on 2020/05/02.
//  Copyright © 2020 kyo_s. All rights reserved.
//

import UIKit
import AVFoundation

extension UIViewController:AVCapturePhotoCaptureDelegate {
    //映像をキャプチャする
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
//        //データを取り出す
//        guard let photoData = photo.fileDataRepresentation() else {
//            return
//        }
////        //Dataから写真イメージを作る
//        if let stillImage = UIImage(data: photoData) {
//            //移動先のビューコントローラーを参照する
//            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "preview")as! previewViewController
//            //トランジションの映像効果を指定する
//            //            nextVC?.modalTransitionStyle = .flipHorizontal
//            nextVC.image = stillImage
//            //シーンを移動する
//            present(nextVC, animated: true, completion: nil)
//        }
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var shutterButton: UIButton!

    var previewLayer: AVCaptureVideoPreviewLayer!
    // インスタンスの作成
    var session = AVCaptureSession()
    var photoOutputObj = AVCapturePhotoOutput()
    // 通知センターを作る
    let notification = NotificationCenter.default
    // プライバシーと入出力のステータス
    var authStatus:AuthorizedStatus = .authorized
    var inOutStatus:InputOutputStatus = .ready
    // 認証のステータス
    enum AuthorizedStatus {
        case authorized
        case notAuthorized
        case failed
    }
    // 入出力のステータス
    enum InputOutputStatus {
        case ready
        case notReady
        case failed
    }

    // ビューが表示された直後に実行
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // セッション実行中ならば中断する
        guard !session.isRunning else {
            return
        }
        // カメラのプライバシー認証確認
        cameraAuth()
        // 入出力の設定
        setupInputOutput()
        // カメラの準備ができているかどうか
        if (authStatus == .authorized)&&(inOutStatus == .ready){
            // プレビューレイヤの設定
            setPreviewLayer()
            // セッション開始
            session.startRunning()
            shutterButton.isEnabled = true
        } else {
            // アラートを出す
            showAlert(appName: "カメラ")
        }
    }

    // シャッターボタンで実行する
    @IBAction func takePhoto(_ sender: Any) {
        if (authStatus == .authorized)&&(inOutStatus == .ready){
            let captureSetting = AVCapturePhotoSettings()
            captureSetting.flashMode = .auto
            captureSetting.isAutoStillImageStabilizationEnabled = true
            captureSetting.isHighResolutionPhotoEnabled = false
            // キャプチャのイメージ処理はデリゲートに任せる
            photoOutputObj.capturePhoto(with: captureSetting, delegate: self)
        } else {
            // カメラの利用を許可しなかったにも関わらずボタンをタップした（初回起動時のみ）
            showAlert(appName: "カメラ")
        }
    }

    // カメラのプライバシー認証確認
    func cameraAuth(){
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch status {
        case .notDetermined:
            // 初回起動時
            AVCaptureDevice.requestAccess(for: AVMediaType.video,
                                          completionHandler: { [unowned self] authorized in
                                            print("初回", authorized.description)
                                            if authorized {
                                                self.authStatus = .authorized
                                            } else {
                                                self.authStatus = .notAuthorized
                                            }})
        case .restricted, .denied:
            authStatus = .notAuthorized
        case .authorized:
            authStatus = .authorized
        }
    }
    
    // 入出力の設定
    func setupInputOutput(){
        //解像度の指定
        session.sessionPreset = AVCaptureSession.Preset.photo
        // 入力の設定
        do {
            //デバイスの取得
            let device = AVCaptureDevice.default(
                AVCaptureDevice.DeviceType.builtInWideAngleCamera,
                for: AVMediaType.video, // ビデオ入力
                position: AVCaptureDevice.Position.back) // バックカメラ
            
            // 入力元
            let input = try AVCaptureDeviceInput(device: device!)
            if session.canAddInput(input){
                session.addInput(input)
            } else {
                print("セッションに入力を追加できなかった")
                return
            }
        } catch  let error as NSError {
            print("カメラがない \(error)")
            return
        }
        
        // 出力の設定
        if session.canAddOutput(photoOutputObj) {
            session.addOutput(photoOutputObj)
        } else {
            print("セッションに出力を追加できなかった")
            return
        }
    }
    
    // UIInterfaceOrientation -> AVCaptureVideoOrientationにConvert
    func convertUIOrientation2VideoOrientation(f: () -> UIInterfaceOrientation) -> AVCaptureVideoOrientation? {
        let v = f()
        switch v {
        case UIInterfaceOrientation.unknown: return nil
        default:
            return ([
                .portrait: .portrait,
                .portraitUpsideDown: .portraitUpsideDown,
                .landscapeLeft: .landscapeLeft,
                .landscapeRight: .landscapeRight
                ])[v]
        }
    }
    
    func appOrientation() -> UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }
    
    // プレビューレイヤの設定
    func setPreviewLayer(){
        // プレビューレイヤを作る
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.bounds
        previewLayer.masksToBounds = true
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        if let orientation = self.convertUIOrientation2VideoOrientation(f: { return self.appOrientation() } ) {
            previewLayer.connection?.videoOrientation = orientation
        }
        // previewViewに追加する
        previewView.layer.addSublayer(previewLayer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let previewLayer = previewLayer {
            previewLayer.frame = view.bounds
        }
    }
    
    // 画面の回転にも対応したい時は viewWillTransitionToSize で同じく向きを教える。
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(
            alongsideTransition: nil,
            completion: {(UIViewControllerTransitionCoordinatorContext) in
                //画面の回転後に向きを教える。
                if let orientation = self.convertUIOrientation2VideoOrientation(f: {return self.appOrientation()}) {
                    self.previewLayer.connection?.videoOrientation = orientation
                }
        }
        )
    }
    
    // プライバシー認証のアラートを表示する
    func showAlert(appName:String){
        let aTitle = appName + "のプライバシー認証"
        let aMessage = "設定＞プライバシー＞" + appName + "で利用を許可してください。"
        let alert = UIAlertController(title: aTitle, message: aMessage, preferredStyle: .alert)
        // OKボタン（何も実行しない）
        alert.addAction(
            UIAlertAction(title: "OK",style: .default,handler: nil)
        )
        // 設定を開くボタン
        alert.addAction(
            UIAlertAction(
                title: "設定を開く",style: .default,
                handler:  { action in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            })
        )
        // アラートを表示する
        self.present(alert, animated: false, completion:nil)
    }
}
