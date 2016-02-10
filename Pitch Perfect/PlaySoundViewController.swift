//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Eva Berkovics on 7/1/15.
//  Copyright (c) 2015 JoeBlack92. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
  
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")
//        {
//            var filePathUrl = NSURL.fileURLWithPath(filePath)
//            
//            
//        }
//        
//        else{
//            println("the audio is missing")
//        }
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        
        audioPlayer.enableRate=true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)

    }
    
    @IBAction func playFastAudio(sender: AnyObject) {
        audioPlayer.stop()
        audioPlayer.rate=2.0
        audioPlayer.currentTime=0
        audioPlayer.play()
    }
    
    @IBAction func playSlowAudio(sender: AnyObject) {
        audioPlayer.stop()
        audioPlayer.rate=0.5
        audioPlayer.currentTime=0
        audioPlayer.play()
    }

    @IBAction func playVaderAudio(sender: AnyObject) {
        playAudioWithVariablePitch(-1000)
    }
    @IBAction func playChipmunkAudio(sender: AnyObject) {
        
        playAudioWithVariablePitch(1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    @IBAction func stopAudio(sender: AnyObject) {
        audioPlayer.stop()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
