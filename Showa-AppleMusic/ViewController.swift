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
    @IBOutlet weak var timePicker: UIPickerView!
    var mins = 15
    let pickerData = [[00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59], ["mins"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.reloadAllComponents()
        reset()
        setup()
        self.timePicker.dataSource = self
        self.timePicker.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    func setup() {
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize.zero
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 15
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        
        timePicker.setValue(UIColor.tcPurple, forKeyPath: "textColor")
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func reset() {
        self.timePicker.selectRow(0, inComponent: 0, animated: true)
        self.timePicker.selectRow(0, inComponent: 1, animated: true)
        timePicker.reloadAllComponents()
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
        
        return pickerData[0][timePicker.selectedRow(inComponent: 0)] as! Int
    }

}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.width/3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(pickerData[component][row])"
        case 1:
            return "mins"
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            mins = pickerData[0][row] as! Int
        default:
            print("fail")
        }
    }

}

