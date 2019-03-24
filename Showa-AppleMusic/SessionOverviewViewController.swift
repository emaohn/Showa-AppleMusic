//
//  SessionOverviewViewController.swift
//  Showa-AppleMusic
//
//  Created by Emmie Ohnuki on 3/23/19.
//  Copyright © 2019 Emmie Ohnuki. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SessionOverviewViewController: UIViewController {
    var userData = [DataSnapshot]()
    var dataRetrieved = false
    let days = ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"]
    var data: DataSnapshot?
    var secondsPassed = 0
    let galPerMin = 2.1
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var timeSpentLabel: UILabel!
    @IBOutlet weak var comparisonLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    var ref: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        DispatchQueue.main.async {
//            self.retrieveData()
//        }
        
        
        setup()
    }
    
    func setup() {
        let minNum = String(format: "%02d", abs(secondsPassed / 60))
        let secNum = String(format: "%02d", abs(secondsPassed % 60))
        timeSpentLabel.text = "\(minNum)m \(secNum)s"
        
        let aveTime = getAverage()
        let difference = abs(aveTime - secondsPassed)
        comparisonLabel.text = "That's \(difference / 60) minutes less than your average time."
        if aveTime >= secondsPassed {
            rewardLabel.text = "Nice! You spent"
            timeSpentLabel.textColor = UIColor.tcPurple
            comparisonLabel.text = "That's \(difference / 60) minutes less than your average time."
        } else {
            rewardLabel.text = "Oh no! You spent"
            comparisonLabel.text = "That's \(difference / 60) minutes more than your average time."
            timeSpentLabel.textColor = UIColor.red
        }
    }
    
//    func retrieveData() {
//        let dataRef = Database.database().reference().child("user")
//        let dispatchGroup = DispatchGroup()
//        dispatchGroup.enter()
//
//        DispatchQueue.main.async {
//            dataRef.observeSingleEvent(of: .value) { (snapshot) in
//
//                guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {return }
//
//                self.userData = [DataSnapshot]()
//
//                for user in snapshot {
//                    self.userData.append(user)
//                }
//
//                dispatchGroup.leave()
//                self.dataRetrieved = true
//            }
//        }
//    }
    
    func getAverage() -> Int {
        let stat = userData[0].value as! [String: Any]
        let aveTime = stat["aveTime"] as! Int
        return aveTime
    }
    
    func calculateNewAverage() -> Int{
        let stat = userData[0].value as! [String: Any]
        var sum = 0
        for day in days {
            let time = stat[day] as! Int
            sum += time
        }
        return sum / 7
    }
    
//    func calculateNewAverage() -> Int {
//        let dataRef = Database.database().reference().child("user1")
//        dataRef.observeSingleEvent(of: .value) { (snapshot) in
//
//            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {return }
//
//            self.stuff = [DataSnapshot]()
//
//            for thing in snapshot {
//                self.stores.append(store)
//            }
//        }
//    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "back", sender: self)
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "back", sender: self)
        let weekdayNum = Calendar.current.component(.weekday, from: Date())
        
        let weekDay = days[weekdayNum - 1]
        ref?.child("user/user1/\(weekDay)").setValue(secondsPassed)
        ref?.child("user/user1/aveTime").setValue(calculateNewAverage())
    }
    
}
