//
//  SessionViewController.swift
//  Showa-AppleMusic
//
//  Created by Emmie Ohnuki on 3/23/19.
//  Copyright © 2019 Emmie Ohnuki. All rights reserved.
//

import UIKit
import Darwin

class SessionViewController: UIViewController {
    var minutes = 0
    var seconds = 0;
    var timer = Timer()
    var isTimerRunning = false
    var countDownInit = 5
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var endSessionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
        startCountdown()
    }
    
    func setup() {
        endSessionButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        endSessionButton.layer.shadowOpacity = 1
        endSessionButton.layer.shadowOffset = CGSize.zero
        endSessionButton.layer.shadowColor = UIColor.black.cgColor
        endSessionButton.layer.shadowRadius = 15
        endSessionButton.layer.cornerRadius = 25
        endSessionButton.layer.masksToBounds = true
        
        timerLabel.text = "5"
    }
    
    func startCountdown() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateInitialCountdown), userInfo: nil, repeats: true)
    }
    
    @objc func updateInitialCountdown() {
        timerLabel.text = "\(countDownInit)"
        if countDownInit != 0 {
            countDownInit -= 1
        } else {
            endTimer()
            seconds = minutes * 60
            startShowerTimer()
        }
    }
    
    func endTimer(){
        timer.invalidate()
    }
    
    func startShowerTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        let minNum = String(format: "%02d", seconds / 60)
        let secNum = String(format: "%02d", seconds % 60)
        timerLabel.text = "\(minNum):\(secNum)";
        if seconds != 0 {
            seconds -= 1
        } else {
            endTimer()
        }
    }
    
    @IBAction func endSessionButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "back", sender: nil)
    }
    
}

extension SessionViewController {
    @objc func swipeAction(swipe:UISwipeGestureRecognizer) {
        switch swipe.direction.rawValue {
        case 1:
            self.performSegue(withIdentifier: "back", sender: self)
        default:
            break
        }
    }
}
