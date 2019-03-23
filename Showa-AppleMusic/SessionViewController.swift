//
//  SessionViewController.swift
//  Showa-AppleMusic
//
//  Created by Emmie Ohnuki on 3/23/19.
//  Copyright © 2019 Emmie Ohnuki. All rights reserved.
//

import UIKit
import MediaPlayer

class SessionViewController: UIViewController, MPMediaPickerControllerDelegate{
    var minutes = 0
    var seconds = 0;
    var timer = Timer()
    var countDownInit = 5
    var myMediaPlayer = MPMusicPlayerApplicationController.systemMusicPlayer
    @IBOutlet weak var selectMusicButton: UIButton!
    
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
        startMusic()
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
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        let minNum = String(format: "%02d", abs(seconds / 60))
        let secNum = String(format: "%02d", abs(seconds % 60))
        timerLabel.text = "\(minNum):\(secNum)";
        seconds -= 1
        if seconds == 0 {
            endMusic()
        }
        
        if seconds < 0 {
            timerLabel.textColor = UIColor.red
        }
    }
    
    func startMusic() {
        myMediaPlayer.play()
    }
    
    func endMusic() {
        myMediaPlayer.stop()
    }
    
    @IBAction func endSessionButtonPressed(_ sender: Any) {
        endTimer()
        endMusic()
        self.performSegue(withIdentifier: "sessionOverview", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "back": endMusic()
        case "sessionOverview":
            endMusic()
        default: break
        }
    }
    @IBAction func selectMusicButtonPressed(_ sender: UIButton) {
        let myMediaPickerVC = MPMediaPickerController(mediaTypes: MPMediaType.music)
        myMediaPickerVC.allowsPickingMultipleItems = true
        myMediaPickerVC.popoverPresentationController?.sourceView = sender
        myMediaPickerVC.delegate = self
        self.present(myMediaPickerVC, animated: true, completion: nil)
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true, completion: nil)
    }
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        myMediaPlayer.setQueue(with: mediaItemCollection)
        mediaPicker.dismiss(animated: true, completion: nil)
        startCountdown()
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
