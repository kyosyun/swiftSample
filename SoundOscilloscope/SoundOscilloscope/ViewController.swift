//
//  ViewController.swift
//  SoundOscilloscope
//
//  Created by 許駿 on 2021/01/14.
//

import AudioToolbox
import UIKit

private func AudioQueueInputCallback(
    _ inUserData: UnsafeMutableRawPointer?,
    inAQ: AudioQueueRef,
    inBuffer: AudioQueueBufferRef,
    inStartTime: UnsafePointer<AudioTimeStamp>,
    inNumberPacketDescriptions: UInt32,
    inPacketDescs: UnsafePointer<AudioStreamPacketDescription>?){

    /* ここでマイク入力されたデータを扱いたい*/
    print(inBuffer);    //???

}

class ViewController: UIViewController {
    
    var queue: AudioQueueRef!
    var audioQueue: AudioQueueRef? = nil
    var timer: Timer!
    
    @IBOutlet weak var loudLabel: UILabel!
    @IBOutlet weak var peakTextField: UITextField!
    @IBOutlet weak var averageTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.startUpdatingVolume()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.stopUpdatingVolume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Internal methods
    func startUpdatingVolume() {
        // Set data format
        var dataFormat = AudioStreamBasicDescription(
            mSampleRate: 44100.0,
            mFormatID: kAudioFormatLinearPCM,
            mFormatFlags: AudioFormatFlags(kLinearPCMFormatFlagIsBigEndian | kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked),
            mBytesPerPacket: 2,
            mFramesPerPacket: 1,
            mBytesPerFrame: 2,
            mChannelsPerFrame: 1,
            mBitsPerChannel: 16,
            mReserved: 0)

        // Observe input level
        var audioQueue: AudioQueueRef? = nil
        var error = noErr
        error = AudioQueueNewInput(
            &dataFormat,
            AudioQueueInputCallback,
            UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()),
            .none,
            .none,
            0,
            &audioQueue)
        if error == noErr {
            self.queue = audioQueue
        }
        AudioQueueStart(self.queue, nil)

        // Enable level meter
        var enabledLevelMeter: UInt32 = 1
        AudioQueueSetProperty(self.queue, kAudioQueueProperty_EnableLevelMetering, &enabledLevelMeter, UInt32(MemoryLayout<UInt32>.size))

        self.timer = Timer.scheduledTimer(timeInterval: 0.5,
                                                            target: self,
                                                            selector: #selector(self.detectVolume(_:)),
                                                            userInfo: nil,
                                                            repeats: true)
        self.timer?.fire()
    }

    func stopUpdatingVolume()
    {
        // Finish observation
        self.timer.invalidate()
        self.timer = nil
        AudioQueueFlush(self.queue)
        AudioQueueStop(self.queue, false)
        AudioQueueDispose(self.queue, true)
    }

    @objc func detectVolume(_ timer: Timer)
        {
            // Get level
            var levelMeter = AudioQueueLevelMeterState()
            var propertySize = UInt32(MemoryLayout<AudioQueueLevelMeterState>.size)

            AudioQueueGetProperty(
                self.queue,
                kAudioQueueProperty_CurrentLevelMeterDB,
                &levelMeter,
                &propertySize)

            // Show the audio channel's peak and average RMS power.
            self.peakTextField.text = "".appendingFormat("%.2f", levelMeter.mPeakPower)
            self.averageTextField.text = "".appendingFormat("%.2f", levelMeter.mAveragePower)

            // Show "LOUD!!" if mPeakPower is larger than -1.0
            self.loudLabel.isHidden = (levelMeter.mPeakPower >= -1.0) ? false : true
        }
  }

