//
//  ViewController.swift
//  MediaLibrary
//
//  Created by 許駿 on 2021/01/14.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {
    
    @IBOutlet weak var bgmName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    var selectedMediaItem: MPMediaItem?
    var musicPlayManager: MusicPlayManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        musicPlayManager = MusicPlayManager.init()
    }
    
    func updateMediaInfo(_ mediaItem: MPMediaItem) {
        bgmName.text = mediaItem.title
        artistName.text = mediaItem.artist
        selectedMediaItem = mediaItem
        do {
            try musicPlayManager?.prepare(mediaItem)
        } catch {
            
        }
    }
    
    
    @IBAction func selectMusic(_ sender: UIButton) {
        let picker = MediaPickerController()
        picker.delegate = self
        picker.allowsPickingMultipleItems = false
        picker.showsCloudItems = false
        picker.showsItemsWithProtectedAssets = false
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func play(_ sender: UIButton) {
        do {
            try musicPlayManager?.play()
        } catch {
            
        }
        
    }
}

extension ViewController: MPMediaPickerControllerDelegate {
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        guard let mediaItem = mediaItemCollection.items.first else { return }
        
        mediaPicker.dismiss(animated: true) {
            self.updateMediaInfo(mediaItem)
        }
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true, completion: nil)
    }
}

class MusicPlayManager: ObservableObject {
    private lazy var playerNode = AVAudioPlayerNode()
    private lazy var eqNode = AVAudioUnitEQ()
    private lazy var engine = AVAudioEngine()
    
    init() {
        self.engine.attach(self.playerNode)
        self.engine.attach(self.eqNode)
        
        self.eqNode = AVAudioUnitEQ(numberOfBands: self.eqParameters.count)
                self.eqNode.bands.enumerated().forEach { index, param in
                    param.filterType = self.eqParameters[index].type
                    param.bypass = false
                    if let bandWidth = self.eqParameters[index].bandWidth {
                        param.bandwidth = bandWidth
                    }
                    param.frequency = self.eqParameters[index].frequency
                    param.gain = self.eqParameters[index].gain
                }
    }
    
    func prepare(_ item: MPMediaItem) throws {
        guard let path = item.assetURL else {
            return
        }
        
        let audioFile = try AVAudioFile(forReading: path)
        
        self.engine.connect(self.playerNode, to: self.eqNode, format: audioFile.processingFormat)
        self.engine.connect(self.eqNode, to: self.engine.mainMixerNode, format: audioFile.processingFormat)
        
        self.playerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
        
    }
    
    func play() throws {
        try AVAudioSession.sharedInstance().setCategory(.playback)
        try AVAudioSession.sharedInstance().setActive(true, options: [])
        try self.engine.start()
        self.playerNode.play()
        
        let eqNode = AVAudioUnitEQ(numberOfBands: 10)
    }
    
    struct EQParameter {
        let type: AVAudioUnitEQFilterType
        let bandWidth: Float?
        let frequency: Float
        let gain: Float
    }
    
    private var eqParameters: [EQParameter] = [
        EQParameter(type: .parametric, bandWidth: 1.0, frequency: 32.0, gain: 3.0),
        EQParameter(type: .parametric, bandWidth: 1.0, frequency: 64.0, gain: 3.0),
        EQParameter(type: .parametric, bandWidth: 1.0, frequency: 128.0, gain: 3.0),
        EQParameter(type: .parametric, bandWidth: 1.0, frequency: 256.0, gain: 2.0),
        EQParameter(type: .parametric, bandWidth: 1.0, frequency: 500.0, gain: 0.0),
        EQParameter(type: .parametric, bandWidth: 1.0, frequency: 1000.0, gain: -6.0),
        EQParameter(type: .parametric, bandWidth: 1.0, frequency: 2000.0, gain: -6.0),
        EQParameter(type: .parametric, bandWidth: 1.0, frequency: 4000.0, gain: -6.0),
        EQParameter(type: .parametric, bandWidth: 1.0, frequency: 8000.0, gain: -6.0),
        EQParameter(type: .parametric, bandWidth: 1.0, frequency: 16000.0, gain: -6.0)
    ]
    
}

class MediaPickerController: MPMediaPickerController {
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.landscapeLeft, .landscapeRight, .portrait]
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }
}
