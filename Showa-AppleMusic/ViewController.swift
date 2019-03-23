//
//  ViewController.swift
//  Showa-AppleMusic
//
//  Created by Emmie Ohnuki on 3/23/19.
//  Copyright © 2019 Emmie Ohnuki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    var time = 15
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }

    func setup() {
        time = 15
        timeLabel.text = "\(time)"
        
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize.zero
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 15
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
    }
    
    func reloadTime() {
        if time > 15{
            timeLabel.textColor = UIColor.red
        } else {
            timeLabel.textColor = UIColor.tcPurple
        }
        let minNum = String(format: "%02d", time)
        timeLabel.text = "\(minNum)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "beginSession":
            guard let destination = segue.destination as? SessionViewController else {return}
            destination.minutes = getTime()
        default: return
        }
    }
    
    func getTime()-> Int{
        
        return time
    }

    @IBAction func upButtonPressed(_ sender: Any) {
        time += 1
        reloadTime()
    }
    
    @IBAction func downButtonPressed(_ sender: Any) {
        if time > 0 {
            time -= 1
            reloadTime()
        }
    }
}

