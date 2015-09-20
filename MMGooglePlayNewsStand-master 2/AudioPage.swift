//
//  AudioPage.swift
//  MMGooglePlayNewsStand
//
//  Created by Patrick Li on 9/20/15.
//  Copyright (c) 2015 madapps. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class AudioPage: UIViewController {

    
    @IBOutlet weak var button: UIButton!
    var newsAudioArray: [NSURL]! = []
    var audioPlayer = AVQueuePlayer()
    var curIndex = -1
    var selected = false
    
    
    @IBOutlet weak var rewind: UIButton!
    @IBOutlet weak var fastforward: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.setImage(UIImage(named: "pauseButton"), forState: .Normal)
        button.enabled = true
        
        rewind.setImage(UIImage(named: "rewindButton"), forState: .Normal)
        fastforward.setImage(UIImage(named: "fastforwardButton"), forState: .Normal)
        
        var coinSound1 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("baby", ofType: "wav")!)
        //NSURL(fileURLWithPath: "")
        var coinSound2 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("laugh", ofType: "wav")!)
        var coinSound3 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("fart", ofType: "wav")!)
        newsAudioArray.append(coinSound1!)
        newsAudioArray.append(coinSound2!)
        newsAudioArray.append(coinSound3!)
        
        
        audioPlayer = AVQueuePlayer(playerItem: AVPlayerItem(URL: newsAudioArray[1]))
        didSelectAudio(audioPlayer)
    }
    
    func didSelectAudio(audio: AVQueuePlayer){
        audio.play()
    }
    
    
    
    
    
    
    @IBAction func pressPause(sender: UIButton) {
        
        if (selected == true) {
            selected = false
            audioPlayer.play()
            button.setImage(UIImage(named: "pauseButton"), forState: .Normal)
            
        } else {
            selected = true
            audioPlayer.pause()
            button.setImage(UIImage(named: "playButton"), forState: .Normal)
        }
        
    }
    
    @IBAction func decreaseRate(sender: AnyObject) {
        if(audioPlayer.rate - 1 > 0){
            audioPlayer.rate = audioPlayer.rate - 1
        }
    }
    @IBAction func increaseRate(sender: AnyObject) {
        if(audioPlayer.rate + 1 < 4){
            audioPlayer.rate = audioPlayer.rate + 1
        }
    }
    

}
