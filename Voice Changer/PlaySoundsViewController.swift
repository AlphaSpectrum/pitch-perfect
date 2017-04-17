//
//  PlaySoundsViewController.swift
//  Voice Changer
//
//  Created by Alan Campos on 4/17/17.
//  Copyright © 2017 Alan Campos. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case chipmunk = 0, vader
    }
    
    @IBAction func playSound(_ sender: UIButton) {
        switch (ButtonType(rawValue: sender.tag)!) {
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        }
        
        configureUI(.playing)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        stopAudio()
    }


}
