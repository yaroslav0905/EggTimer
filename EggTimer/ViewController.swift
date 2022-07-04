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
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var textTop: UILabel!
    
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer!
    
    @objc func updateTimer() {
         if secondsPassed <  totalTime {
             secondsPassed += 1
             progressView.progress = Float(secondsPassed) / Float(totalTime)
             
         } else {
            timer.invalidate()
            textTop.text = "Done"
             let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
             player = try! AVAudioPlayer(contentsOf: url!)
             player.play()
         }
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        progressView.progress = 0.0
        secondsPassed = 0
        textTop.text = sender.currentTitle!
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
}
