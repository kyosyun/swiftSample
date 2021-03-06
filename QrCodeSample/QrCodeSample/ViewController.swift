//
//  ViewController.swift
//  QrCodeSample
//
//  Created by 許　駿 on 2018/07/21.
//  Copyright © 2018年 kyo_s. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    // カメラやマイクの入出力を管理するオブジェクトを生成
    private let session = AVCaptureSession()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // カメラやマイクのデバイスそのものを管理するオブジェクトを生成（ここではワイドアングルカメラ・ビデオ・背面カメラを指定）
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
                                                                mediaType: .video,
                                                                position: .back)

        // ワイドアングルカメラ・ビデオ・背面カメラに該当するデバイスを取得
        let devices = discoverySession.devices

        //　該当するデバイスのうち最初に取得したものを利用する
        if let backCamera = devices.first {
            do {
                // QRコードの読み取りに背面カメラの映像を利用するための設定
                let deviceInput = try AVCaptureDeviceInput(device: backCamera)

                if self.session.canAddInput(deviceInput) {
                    self.session.addInput(deviceInput)

                    // 背面カメラの映像からQRコードを検出するための設定
                    let metadataOutput = AVCaptureMetadataOutput()

                    if self.session.canAddOutput(metadataOutput) {
                        self.session.addOutput(metadataOutput)

                        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                        metadataOutput.metadataObjectTypes = [.qr]

                        // 背面カメラの映像を画面に表示するためのレイヤーを生成
                        let previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
                        previewLayer.frame = self.view.bounds
                        previewLayer.videoGravity = .resizeAspectFill
                        self.view.layer.addSublayer(previewLayer)

                        // 読み取り開始
                        self.session.startRunning()
                    }
                }
            } catch {
                print("Error occured while creating video device input: \(error)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        for metadata in metadataObjects as! [AVMetadataMachineReadableCodeObject] {
            // QRコードのデータかどうかの確認
            if metadata.type != .qr { continue }

            // QRコードの内容が空かどうかの確認
            if metadata.stringValue == nil { continue }
            print(metadata.stringValue!)
            /*
             このあたりで取得したQRコードを使ってゴニョゴニョする
             読み取りの終了・再開のタイミングは用途によって制御が異なるので注意
             以下はQRコードに紐づくWebサイトをSafariで開く例
             */

            // URLかどうかの確認
            if let url = URL(string: metadata.stringValue!) {
                // 読み取り終了
                self.session.stopRunning()
                // QRコードに紐付いたURLをSafariで開く
                UIApplication.shared.open(url, options: [:], completionHandler: nil)

                break
            }

            guard let values = metadata.stringValue?.split(separator: "/") else {
                return
            }

            //軽自動車の場合 (QRが3つ）
            let count = values.count

            switch count {
            case 6: //QR1
                //1. システムID
                //2. バージョン番号
                //3. 輸出整理番号
                //4. 車両番号
                //5. 車台番号
                //6. 型式指定番号 + 類別区分番号

                break
            case 7: //QR2
                //1. システムID
                //2. バージョン番号
                //3. 車両番号
                //4. 標板の枚数・大きさ
                //5. 車台番号
                //6. 原動機かた
                //7. 帳票種別
                break
            case 19: //QR13
                //1. システムID
                //2. ナージョン番号
                //3. 車台番号
                //4. 型式指定番号 + 類別区分番号
                //5. 有効期間満了日 (YYMMDD)
                //6. 初年度検査年月(YYMM） 未設定：9999 / 月が未設定 YY99
                //7. 型式
                //8. 軸重（前前）ex 0123 -> 1230kg
                //9. 軸重（前後） 不要
                //10. 軸重（後前）　不要
                //11. 軸重（後後）ex 0123 -> 1230kg

                break
            default:
                break
            }

            //自動車の場合(QR 5種？）
            switch count {
            case 7: // QR1 QR3 不要

                if values[0] == "2" { //QR1の場合
                    break
                }
                // QR3の場合

            case 6: // QR2 QR8 不要？
                break
            case 8: // QR4
                break
            case 2: // QR5
                break
            case 5: // QR6
                break
            default:
                break
            }


        }
    }
}

