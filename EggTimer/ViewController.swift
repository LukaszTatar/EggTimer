//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes:[String:Int] = ["Soft":300, "Medium":420, "Hard":720]
    var totalTime = 0
    var timePassed = 0
    var timer = Timer()
    var player: AVAudioPlayer!

    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        timer.invalidate()
        progressBar.progress = 0.0
        timePassed = 0
        timerLabel.text = hardness

        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
            
    }
    
    @objc func updateCounter(){
        if timePassed < totalTime {
            let percentageProgess : Float = Float(timePassed) / Float(totalTime)
            progressBar.progress = percentageProgess
            timePassed += 1
            
            
        } else {
            timer.invalidate()
            timerLabel.text = "Done!"
            progressBar.progress = 1.0
            playSound()
        }
    }
    
}
