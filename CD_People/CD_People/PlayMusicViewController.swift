//
//  PlayMusicViewController.swift
//  CD_People
//
//  Created by Nathan Ryan O Hehir on 13/04/2018.
//  Copyright © 2018 Ankita Singh. All rights reserved.
//

import UIKit
import AVFoundation

class PlayMusicViewController: UIViewController {
    
    @IBOutlet weak var currentTrack: UILabel!
    var audioplayer = AVAudioPlayer()
    @IBOutlet weak var durationLabel: UILabel!
    var track = ""
    var isPlaying = false
    var timer:Timer!
    
    
    @IBAction func trackBtn(_ sender: UIButton) {
        if (sender.currentTitle! == "Queens of the Stone Age"){
            track = "qotsa"
            
        }
        else if (sender.currentTitle! == "Foo Fighters"){
            track = "ff"
        }
        else if (sender.currentTitle! == "Red Hot Chilli Peppers"){
            track = "rhcp"
        }
        currentTrack.text = sender.currentTitle!
    }
    
    @IBAction func PlayStopBtn(_ sender: UIButton) {
        do {
            audioplayer = try AVAudioPlayer( contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: track, ofType: "mp3")!))
            audioplayer.prepareToPlay()
        }
        catch{
            print(error)
        }
        if sender.currentTitle == "Play"{
            self.play()
        }
        else{
            self.stop()
        }
    }
    
    func play(){
       audioplayer.play()
    }
    
    func stop(){
        audioplayer.stop()
        audioplayer.currentTime = 0
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
