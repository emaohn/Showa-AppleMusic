//
//  SessionOverviewViewController.swift
//  Showa-AppleMusic
//
//  Created by Emmie Ohnuki on 3/23/19.
//  Copyright © 2019 Emmie Ohnuki. All rights reserved.
//

import UIKit

class SessionOverviewViewController: UIViewController {
    var secondsPassed = 0
    let galPerMin = 2.1
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var timeSpentLabel: UILabel!
    @IBOutlet weak var comparisonLabel: UILabel!
    @IBOutlet weak var waterSavedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    func setup() {
        let minNum = String(format: "%02d", abs(secondsPassed / 60))
        let secNum = String(format: "%02d", abs(secondsPassed % 60))
        timeSpentLabel.text = "\(minNum)m \(secNum)s"
        
        let aveTime = 1200
        let difference = abs(aveTime - secondsPassed)
        comparisonLabel.text = "That's \(difference / 60) minutes less than your average time."
        let waterSaved = String(format: "%.02f", abs(Double(difference / 60) * galPerMin))
        waterSavedLabel.text = "You saved about \(waterSaved) gallons of water!"
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "back", sender: self)
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "back", sender: self)
    }
    
}
