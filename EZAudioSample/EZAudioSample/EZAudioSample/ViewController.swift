//
//  ViewController.swift
//  EZAudioSample
//
//  Created by 許駿 on 2020/11/07.
//  Copyright © 2020 kyo_s. All rights reserved.
//

import UIKit

class ViewController: UIViewController, EZAudioFileDelegate {
    
     var audioFile:EZAudioFile!
     var audioPlot:EZAudioPlot!
     var audioPlayer:EZAudioPlayer!
     var audioCoreGrph:EZAudioPlotGL!
     
     override func viewDidLoad() {
         super.viewDidLoad()

         //波形
         self.audioPlot = EZAudioPlot(frame: self.view.frame)
         self.audioPlot.backgroundColor = UIColor.cyan
         self.audioPlot.color = UIColor.purple
         self.audioPlot.plotType = EZPlotType.buffer
         self.audioPlot.shouldFill = true
         self.audioPlot.shouldMirror = true
         self.audioPlot.shouldOptimizeForRealtimePlot = true

         //ファイルのパスを指定して読み込み
         self.openFileWithFilePathURL(filePathURL: NSURL(fileURLWithPath: Bundle.main.path(forResource: "menuettm", ofType: "mp3")!))
         self.view.addSubview(self.audioPlot)
         
         //再生
         self.audioPlayer.pan = 0
         self.audioPlayer.volume = 50.0
         self.audioPlayer.play()
         
     }
     
     //ファイルの読み込みと波形の読み込み
     func openFileWithFilePathURL(filePathURL:NSURL){
        self.audioFile = EZAudioFile(url: filePathURL as URL?)
         self.audioFile.delegate = self
         
         let buffer = self.audioFile.getWaveformData().buffer(forChannel: 0)
         let bufferSize = self.audioFile.getWaveformData().bufferSize
         self.audioPlot.updateBuffer(buffer, withBufferSize: bufferSize)

         //読み込んだオーディオファイルをプレイヤーに設定して初期化
         self.audioPlayer = EZAudioPlayer(audioFile: self.audioFile)

     }

     override func didReceiveMemoryWarning() {
         super.didReceiveMemoryWarning()
         // Dispose of any resources that can be recreated.
     }
}
