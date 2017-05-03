//
//  ViewController.swift
//  BPMTapper
//
//  Created by Tyler Neveldine on 4/25/17.
//  Copyright © 2017 Tyler Neveldine. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet var BPMLabel: UILabel!
    @IBOutlet var tapButton: UIButton!
    
    var startTimer : Timer!
    var trackingTimer : Timer!
    var previousTapTime = Date()
    var numberOfTaps = 0.0
    var averageBPM = 0.0
    
    @IBAction func tapButtonWasPressed(_ sender: Any)
    {
        let timeDifference = -previousTapTime.timeIntervalSinceNow
        
        if (timeDifference > 5)
        {
            self.numberOfTaps = 0
            self.averageBPM = 0
        }
        
        let BPM = 60 / timeDifference
        
        if (numberOfTaps < 4)
        {
            numberOfTaps += 1
        }
        
        if (numberOfTaps == 1)
        {
            averageBPM = BPM
        }
        else
        {
            averageBPM = (averageBPM * ((numberOfTaps - 1) / numberOfTaps)) + BPM / numberOfTaps
        }
        
        BPMLabel.text = "\(averageBPM)"
        previousTapTime = Date()
        
        if (startTimer != nil)
        {
            startTimer.invalidate()
        }
        if (trackingTimer != nil)
        {
            trackingTimer.invalidate()
        }
        startTimer = Timer.scheduledTimer(withTimeInterval: (60 / averageBPM), repeats: false, block: { (timer) in
            self.startTrackingBPM()
        })
    }

    func startTrackingBPM()
    {
        trackingTimer = Timer.scheduledTimer(withTimeInterval: (60 / averageBPM), repeats: true) { (timer) in
            if (self.view.backgroundColor == UIColor.red)
            {
                self.view.backgroundColor = UIColor.white
            }
            else
            {
                self.view.backgroundColor = UIColor.red
            }
        }
    }
    
}

