//
//  ViewController.swift
//  AVCaptureSessionSample
//
//  Created by 許駿 on 2020/05/02.
//  Copyright © 2020 kyo_s. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // [x] ピンチイン・ピンチアウト
    // [ ] 0.5,1.2 カメラの切り替え
    // [x] 内向きカメラとの切り替え
    // [x] タップ時にエフェクトをつける。
    // [ ] 向きの変更を検知して、向きを入れ替える。
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var zoomBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    
    private var videoDevice: AVCaptureDevice?
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
//    var deviceType: AVCaptureDevice.DeviceType = .builtInWideAngleCamera

    // ズームの制御
    private var baseZoomFanctor: CGFloat = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPinchGestureRecognizer()
        setupTapGesture()
        
        setupUI()
        // Do any additional setup after loading the view.
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
                    self.previewLayer?.connection?.videoOrientation = orientation
                }
        }
        )
    }
    
    func appOrientation() -> UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }
       
    private func setupUI() {
        zoomBtn.layer.cornerRadius = 22
        cameraBtn.layer.cornerRadius = 35
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            setupCaptureSession(withPosition: .back, deviceType: .builtInTripleCamera)
        } else {
            setupCaptureSession(withPosition: .back, deviceType: .builtInWideAngleCamera)
        }
    }
    
    
    private func setupCaptureSession(withPosition cameraPosition: AVCaptureDevice.Position, deviceType: AVCaptureDevice.DeviceType) {
        captureSession = AVCaptureSession()
        stillImageOutput = AVCapturePhotoOutput()
        captureSession.sessionPreset = AVCaptureSession.Preset.photo // 解像度の設定
        videoDevice = AVCaptureDevice.default(deviceType, for: .video, position: cameraPosition)
        
        if videoDevice == nil {
            // deviceが見当たらなかった場合
            videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: cameraPosition)
        }
        
        setupPreviewLayuer()
    }
    
    
    fileprivate func setupPreviewLayuer() {
        do {
            let input = try AVCaptureDeviceInput(device: videoDevice!)
            
            // 入力
            if (captureSession.canAddInput(input)) {
                captureSession.addInput(input)
                guard let stillImageOutput = stillImageOutput else {return}
                
                // 出力
                if (captureSession.canAddOutput(stillImageOutput)) {
                    captureSession.addOutput(stillImageOutput)
                    captureSession.startRunning() // カメラ起動
                    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                    // ビューのサイズの調整
                    previewLayer?.frame = UIScreen.main.bounds
                    previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
                    previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation(rawValue: UIApplication.shared.statusBarOrientation.rawValue) ?? .portrait
                    cameraView.layer.addSublayer(previewLayer!)
                }
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: ピンチイン・ピンチアウト
    
    private func setupPinchGestureRecognizer() {
    // pinch recognizer for zooming
        let pinchGestureRecognizer: UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(self.onPinchGesture(_:)))
        self.view.addGestureRecognizer(pinchGestureRecognizer)
    }
      
    @objc private func onPinchGesture(_ sender: UIPinchGestureRecognizer) {
        if sender.state == .began {
          self.baseZoomFanctor = (self.videoDevice?.videoZoomFactor)!
        }

        let tempZoomFactor: CGFloat = self.baseZoomFanctor * sender.scale
        let newZoomFactdor: CGFloat
        if tempZoomFactor < (self.videoDevice?.minAvailableVideoZoomFactor)! {
          newZoomFactdor = (self.videoDevice?.minAvailableVideoZoomFactor)!
        } else if (self.videoDevice?.maxAvailableVideoZoomFactor)! < tempZoomFactor {
          newZoomFactdor = (self.videoDevice?.maxAvailableVideoZoomFactor)!
        } else {
          newZoomFactdor = tempZoomFactor
        }
        zoomBtn.setTitle(newZoomFactdor.description, for: .normal)

        do {
          try self.videoDevice?.lockForConfiguration()
          self.videoDevice?.ramp(toVideoZoomFactor: newZoomFactdor, withRate: 32.0)
          self.videoDevice?.unlockForConfiguration()
        } catch {
          print("Failed to change zoom factor.")
        }
    }
    
    // MARK : カメラの内・外カメラ切り替え

    @IBAction func tapCameraBtn(_ sender: UIButton) {
        self.reverseCameraPosition()
    }
    
    func reverseCameraPosition() {
        self.captureSession?.stopRunning()
        self.captureSession?.inputs.forEach { input in
            self.captureSession?.removeInput(input)
        }
        self.captureSession?.outputs.forEach { output in
            self.captureSession?.removeOutput(output)
        }

        // prepare new camera preview
        let newCameraPosition: AVCaptureDevice.Position = self.videoDevice?.position == .front ? .back : .front
        if #available(iOS 13.0, *) {
            setupCaptureSession(withPosition: newCameraPosition, deviceType: .builtInTripleCamera)
        } else {
            setupCaptureSession(withPosition: newCameraPosition, deviceType: .builtInWideAngleCamera)
        }
    }
    
    // MARK: タップ時のエフェクト
    
    @objc func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(self.tapViewGesture(touch:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapViewGesture(touch: UITapGestureRecognizer) {
        self.tapEffect(touch: touch)
    }
    
    func tapEffect(touch: UITapGestureRecognizer) {

        // ①: タップされた場所にlayerを置き、半径200の円を描画
        let location = touch.location(in: self.view)
        let layer = CAShapeLayer.init()
        self.view.layer.addSublayer(layer)
        layer.frame = CGRect.init(x: location.x, y: location.y, width: 50, height: 50)
        layer.position = CGPoint.init(x: location.x, y: location.y)
        layer.contents = {
            let size: CGFloat = 100.0
            UIGraphicsBeginImageContext(CGSize.init(width: size, height: size))
            let context = UIGraphicsGetCurrentContext()!
            context.saveGState()
            context.setFillColor(UIColor.clear.cgColor)
            context.fill(self.view.frame)
            let r = CGFloat.init(size/2-10)
            let center = CGPoint.init(x: size/2, y: size/2)
            let path : CGMutablePath = CGMutablePath()
            path.addArc(center: center, radius: r, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: false)
            context.addPath(path)
            context.setFillColor(UIColor.lightGray.cgColor)
            context.setStrokeColor(UIColor.lightGray.cgColor)
            context.drawPath(using: .fillStroke)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            context.restoreGState()
            return image!.cgImage
        }()

        // ②: 円を拡大しつつ透明化するAnimationを用意
        let animationGroup: CAAnimationGroup = {
            let animation: CABasicAnimation = {
                let animation = CABasicAnimation(keyPath: "transform.scale")
                animation.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeOut)
                animation.duration = 0.3
                animation.isRemovedOnCompletion = false
                animation.fillMode = CAMediaTimingFillMode.forwards
                animation.fromValue = NSNumber(value: 0.5)
                animation.toValue = NSNumber(value: 3.0)
                return animation
            }()

            let animation2: CABasicAnimation = {
                let animation = CABasicAnimation(keyPath: "opacity")
                animation.duration = 0.5
                animation.isRemovedOnCompletion = false
                animation.fillMode = CAMediaTimingFillMode.forwards
                animation.fromValue = NSNumber(value: 0.5)
                animation.toValue = NSNumber(value: 0.0)
                return animation
            }()

            let group = CAAnimationGroup()
            group.beginTime = CACurrentMediaTime()
            group.animations = [animation, animation2]
            group.isRemovedOnCompletion = false
            group.fillMode = CAMediaTimingFillMode.backwards
            return group
        }()

        // ③: layerにAnimationを適用
        CATransaction.setAnimationDuration(5.0)
        CATransaction.setCompletionBlock({
            layer.removeFromSuperlayer()
        })
        CATransaction.begin()
        layer.add(animationGroup, forKey: nil)
        layer.opacity = 0.0
        CATransaction.commit()
    }
    
    // UIInterfaceOrientation -> AVCaptureVideoOrientationにConvert
    func convertUIOrientation2VideoOrientation(f: () -> UIInterfaceOrientation) -> AVCaptureVideoOrientation? {
        let v = f()
        switch v {
        case UIInterfaceOrientation.unknown:
                return nil
            default:
                return ([
                    UIInterfaceOrientation.portrait: AVCaptureVideoOrientation.portrait,
                    UIInterfaceOrientation.portraitUpsideDown: AVCaptureVideoOrientation.portraitUpsideDown,
                    UIInterfaceOrientation.landscapeLeft: AVCaptureVideoOrientation.landscapeLeft,
                    UIInterfaceOrientation.landscapeRight: AVCaptureVideoOrientation.landscapeRight
                ])[v]
        }
    }
}

