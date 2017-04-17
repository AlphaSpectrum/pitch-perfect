//
//  RecordAudioViewController.swift
//  Voice Changer
//
//  Created by Alan Campos on 4/15/17.
//  Copyright © 2017 Alan Campos. All rights reserved.
//

import UIKit
import AVFoundation

class RecordAudioViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var tapToRecordLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
    }

    @IBAction func recordAudio(_ sender: Any) {
        recordButton.isEnabled = false
        tapToRecordLabel.text = "RECORDING"
        stopRecordingButton.isEnabled = true
        
        let directoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let nameOfRecording = "recordedVoice.wav"
        let pathArray = [directoryPath, nameOfRecording]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    @IBAction func stopRecordingAudio(_ sender: Any) {
        recordButton.isEnabled = true
        tapToRecordLabel.text = "TAP TO RECORD"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecordingView", sender: audioRecorder.url)
        } else {
            print("Recording Failed")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecordingView" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }

    }
}

