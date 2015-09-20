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

var newId = ""
var entities : [String!] = []

class AudioPage: UIViewController {

    
    @IBOutlet weak var button: UIButton!
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
        
        
        var coinSound2 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("laugh", ofType: "wav")!)
        
        audioPlayer = AVQueuePlayer(playerItem: AVPlayerItem(URL: coinSound2))
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
    
    @IBAction func findMoreArticles(sender: AnyObject){
        
        println(first3Entities)
        
        //println(entities)
        
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "displayEntities")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    @IBAction func back(sender: AnyObject) {
        audioPlayer.pause()
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
