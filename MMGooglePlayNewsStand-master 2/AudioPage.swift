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
<<<<<<< HEAD
=======

class AudioPage: UIViewController {
>>>>>>> origin/master

class AudioPage: UIViewController {
    
    
    @IBOutlet weak var button: UIButton!
<<<<<<< HEAD
    var audioPlayer: AVAudioPlayer?
=======
    var audioPlayer = AVQueuePlayer()
>>>>>>> origin/master
    var curIndex = -1
    var selected = false
    
    
    @IBOutlet weak var rewind: UIButton!
    @IBOutlet weak var fastforward: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.setImage(UIImage(named: "pauseButton"), forState: .Normal)
        button.enabled = true
        println(newId)
        //rewind.setImage(UIImage(named: "rewindButton"), forState: .Normal)
        //fastforward.setImage(UIImage(named: "fastforwardButton"), forState: .Normal)
        
<<<<<<< HEAD
        var coinSound2 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("laugh", ofType: "wav")!)
        
        //var derp = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("derp1", ofType: "mp3")!)
        //audioPlayer = AVAudioPlayer(contentsOfURL: derp, error: nil)
        //didSelectAudio(audioPlayer)
        var newsAudioUrl = NSURL(string: "http://104.236.159.247:8181/static/wav/\(newId).mp3")
        /*http://104.236.159.247:8181/static/wav/\(newId).mp3"*/
        var err:NSErrorPointer = NSErrorPointer()
        //        audioPlayer = AVAudioPlayer(contentsOfURL: newsAudioUrl, error: err)
        var newsAudio = NSData(contentsOfURL: newsAudioUrl!)
        //audioPlayer = AVAudioPlayer()
        var error: NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: newsAudioUrl, error: &error)
        audioPlayer?.prepareToPlay()
        println(error)
        //audioPlayer.rate = 1.0
        //audioPlayer.volume = 1.0
        //audioPlayer.play()
        didSelectAudio(audioPlayer!)
=======
        rewind.setImage(UIImage(named: "rewindButton"), forState: .Normal)
        fastforward.setImage(UIImage(named: "fastforwardButton"), forState: .Normal)
        
        
        var coinSound2 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("laugh", ofType: "wav")!)
        
        audioPlayer = AVQueuePlayer(playerItem: AVPlayerItem(URL: coinSound2))
        didSelectAudio(audioPlayer)
>>>>>>> origin/master
    }
    
    func didSelectAudio(audio: AVAudioPlayer){
        audio.rate = 1.0
        audio.volume = 1.0
        audio.play()
    }
    
    
    
    
    
    
    @IBAction func pressPause(sender: UIButton) {
        
        if (selected == true) {
            selected = false
            audioPlayer?.play()
            button.setImage(UIImage(named: "pauseButton"), forState: .Normal)
            
        } else {
            selected = true
            audioPlayer?.pause()
            button.setImage(UIImage(named: "playButton"), forState: .Normal)
        }
        
    }
    
    @IBAction func findMoreArticles(sender: AnyObject){
        
        println(first3Entities)
<<<<<<< HEAD
=======
        
>>>>>>> origin/master
        //println(entities)
        
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "displayEntities")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    @IBAction func back(sender: AnyObject) {
<<<<<<< HEAD
        audioPlayer?.pause()
=======
        audioPlayer.pause()
>>>>>>> origin/master
    }
    @IBAction func decreaseRate(sender: AnyObject) {
        
        if let audioPlayer = audioPlayer {
            
            
            if(audioPlayer.rate - 1 > 0){
                audioPlayer.rate = audioPlayer.rate - 1
            }
        }
    }
    @IBAction func increaseRate(sender: AnyObject) {
        if let audioPlayer = audioPlayer {
            
            
            if(audioPlayer.rate - 1 > 0){
                audioPlayer.rate = audioPlayer.rate - 1
            }
        }
    }
    
    
}
