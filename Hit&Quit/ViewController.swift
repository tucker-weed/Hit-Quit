//
//  ViewController.swift
//  HelloWorld
//
//  Created by Tucker Weed on 8/24/19.
//  Copyright © 2019 Tucker Weed. All rights reserved.
//

import UIKit

var checker:Bool = false

class ViewController: UIViewController {
    
    @IBOutlet weak var lab:UILabel!
    @IBOutlet weak var lab2:UILabel!
    @IBOutlet weak var lab3:UILabel!
    
    @IBAction func PRINTSOME(sender: UIButton) {
        /*
        let alertController = UIAlertController(title: "Welcome to My First App", message: "Hello World", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alertController, animated: true, completion: nil)
        */
        let defaults = UserDefaults.standard
        
        hits += 1
        defaults.set(hits, forKey: "H")
        
        let temp = String(hits)
        lab.text = temp
        
        
        let date = Date()
        days = String(describing: date)
        
        lab2.text = "0 Days + 00:00:00"
        checker = true

        defaults.set(days, forKey: "T")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        //Get
        hits = defaults.integer(forKey: "H")
        let check = defaults.string(forKey: "T") ?? nil
        
        if (check != nil) {
            days = check!
        }
        
        if days == "" {
            let date = Date()
            days = String(describing: date)
        }
        
        
        
        let temp = String(hits)
        lab.text = temp
        
    
        let date = Date()
        var t1 = 0
        var date2 = Date()
        for _ in days {
            t1 += 1
        }
        if t1 >= 19 {
            date2 = getDate(refr:days)
        }
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([Calendar.Component.second], from:date2, to:date)
        
        let ab = return_formatted(seconds:dateComponents.second!)
        lab2.text = ab
        increase_label(lab:lab2, oth:ab, lab2:lab3)
        
        
        
    }


}

func getDate(refr:String) -> Date {
    
    var dateComponents = DateComponents()
    dateComponents.year = Int(String(refr.prefix(4)))!
    let start = refr.index(refr.startIndex, offsetBy: 5)
    let end = refr.index(refr.startIndex, offsetBy: 7)
    let range = start..<end
    let sub = refr[range]
    
    dateComponents.month = Int(String(sub))!
    
    let start2 = refr.index(refr.startIndex, offsetBy: 8)
    let end2 = refr.index(refr.startIndex, offsetBy: 10)
    let range2 = start2..<end2
    let sub2 = refr[range2]
    
    dateComponents.day = Int(String(sub2))!
    
    let start3 = refr.index(refr.startIndex, offsetBy: 11)
    let end3 = refr.index(refr.startIndex, offsetBy: 13)
    let range3 = start3..<end3
    let sub3 = refr[range3]
    
    dateComponents.hour = Int(String(sub3))!
    
    let start4 = refr.index(refr.startIndex, offsetBy: 14)
    let end4 = refr.index(refr.startIndex, offsetBy: 16)
    let range4 = start4..<end4
    let sub4 = refr[range4]
    
    dateComponents.minute = Int(String(sub4))!
    
    let start5 = refr.index(refr.startIndex, offsetBy: 17)
    let end5 = refr.index(refr.startIndex, offsetBy: 19)
    let range5 = start5..<end5
    let sub5 = refr[range5]
    
    dateComponents.second = Int(String(sub5))! - 3599
    
    let userCalendar = Calendar.current
    let tiemp = userCalendar.date(from: dateComponents)

    
    return tiemp!
}

func increase_label(lab:UILabel, oth:String, lab2:UILabel) {
    DispatchQueue.main.asyncAfter(deadline: .now()) {
        
        let defaults = UserDefaults.standard
        let date = Date()
        var t1 = 0
        var date2 = Date()
        for _ in days {
            t1 += 1
        }
        if t1 >= 19 {
            date2 = getDate(refr:days)
        }
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([Calendar.Component.second], from:date2, to:date)
        
        let new = return_formatted(seconds:dateComponents.second!)
        
        let check = defaults.integer(forKey: "Highestt")
        
        if ((dateComponents.second ?? nil != nil ? dateComponents.second! : 0) + 14400) > check + 14400 {
            defaults.set( (dateComponents.second ?? nil != nil ? dateComponents.second! : 0), forKey: "Highestt")
        }
        
        if checker == false {
            lab.text = oth
            if (dateComponents.second! + 14400) > check + 14400 {
                lab2.text = oth
            } else {
                if check == 0 {
                    defaults.set( ((dateComponents.second ?? nil != nil ? dateComponents.second! : 0)), forKey: "Highestt")
                    lab2.text = "0 Days + 00:00:00"
                } else {
                    lab2.text = return_formatted(seconds:(check))
                }
            }
        }
        checker = false
        increase_label(lab:lab, oth:new, lab2:lab2)
        
    }
}

func return_formatted(seconds:Int) -> String {
    var secs = seconds
    secs += 14400
    var mins = 0
    var hrs = 0
    var days = 0
    
    while secs > 59 {
        secs -= 60
        mins += 1
    }
    while mins > 59 {
        mins -= 60
        hrs += 1
    }
    while hrs > 23 {
        hrs -= 24
        days += 1
    }
    
    
    return "\(days) Days + \(hrs < 10 ? "0"+String(hrs) : String(hrs)):\(mins < 10 ? "0"+String(mins) : String(mins)):\(secs < 10 ? "0"+String(secs) : String(secs))"
}

