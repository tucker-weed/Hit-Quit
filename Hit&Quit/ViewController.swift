//
//  ViewController.swift
//  HelloWorld
//
//  Created by Tucker Weed on 8/24/19.
//  Copyright © 2019 Tucker Weed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lab:UILabel!
    @IBOutlet weak var lab2:UILabel!
    
    @IBAction func PRINTSOME(sender: UIButton) {
        /*
        let alertController = UIAlertController(title: "Welcome to My First App", message: "Hello World", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alertController, animated: true, completion: nil)
        */
        let defaults = UserDefaults.standard
        
        hits += 1
        defaults.set(hits, forKey: "Hits")
        
        let temp = String(hits)
        lab.text = "Hits: "+temp
        
        
        let date = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.short
        
        let st = dateFormatter.string(from: date)
        
        let a = return_delta(new_date:st,old_date:days)
        
        if days != "" {
            lab2.text = "Days: "+String(a)
        }
        
        days = st
        defaults.set(days, forKey: "Days")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        //Get
        hits = defaults.integer(forKey: "Hits")
        let check = defaults.string(forKey: "Days") ?? nil
        if (check != nil) {
            days = check!
        }
        let temp = String(hits)
        lab.text = "Hits: "+temp
        

        if days != "" {
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.none
            dateFormatter.dateStyle = DateFormatter.Style.short
        
            let st = dateFormatter.string(from: date)
            let a = return_delta(new_date:st,old_date:days)
            lab2.text = "Days: "+String(a)
        }
        
    }


}

func return_delta(new_date:String, old_date:String) -> Int {
    
    var arr:[Character] = []
    var month1:Int = 0
    var day1:Int = 0
    var yr1:Int = 0
    var total_days1:Int = 0
    
    for ch in new_date {
        arr.append(ch)
    }
    
    var arr2:[Character] = []
    var month2:Int = 0
    var day2:Int = 0
    var yr2:Int = 0
    var total_days2:Int = 0
    
    for ch in old_date {
        arr2.append(ch)
    }
    
    //////////////
    
    for (key, ch) in arr.enumerated() {
        
        if (key == 0 && arr[key+1] == "/") {
            month1 = Int(String(ch))!
        } else if (key == 0 && arr[key+2] == "/") {
            month1 = Int("\(ch)\(arr[key+1])")!
        }
        if (month1 != 0 && day1 == 0 && ch == "/") {
            if (arr[key+2] == "/") {
                day1 = Int(String(arr[key+1]))!
            } else {
                day1 = Int("\(arr[key+1])\(arr[key+2])")!
            }
        }
        if (key != 1 && day1 != 0 && ch == "/") {
            yr1 = 2000 + Int("\(arr[key+1])\(arr[key+2])")!
        }
    }
    var temp_days = 0
    for a in stride(from:0, to:month1, by:1) {
        
        if (a == 2) {
            temp_days += 28
        }
        if (a <= 7) && (a != 2) && (a % 2 != 0) {
            temp_days += 31
        } else if (a <= 7) && (a != 2) && (a % 2 == 0) {
            temp_days += 30
        }
        if (a > 7) && (a != 2) && (a % 2 == 0) {
            temp_days += 31
        } else if (a > 7) && (a != 2) && (a % 2 != 0){
            temp_days += 30
        }
        
    }
    
    total_days1 = (yr1 * 365) + (temp_days) + (day1)
    
    // Same code, but modded for the second date and its variables
    for (key, ch) in arr2.enumerated() {
        
        if (key == 0 && arr2[key+1] == "/") {
            month2 = Int(String(ch))!
        } else if (key == 0 && arr2[key+2] == "/") {
            month2 = Int("\(ch)\(arr2[key+1])")!
        }
        if (month2 != 0 && day2 == 0 && ch == "/") {
            if (arr2[key+2] == "/") {
                day2 = Int(String(arr2[key+1]))!
            } else {
                day2 = Int("\(arr2[key+1])\(arr2[key+2])")!
            }
        }
        if (key != 1 && day2 != 0 && ch == "/") {
            yr2 = 2000 + Int("\(arr2[key+1])\(arr2[key+2])")!
        }
    }
    var temp_days2 = 0
    for a in stride(from:0, to:month2, by:1) {
        
        if (a == 2) {
            temp_days2 += 28
        }
        if (a <= 7) && (a != 2) && (a % 2 != 0) {
            temp_days2 += 31
        } else if (a <= 7) && (a != 2) && (a % 2 == 0) {
            temp_days2 += 30
        }
        if (a > 7) && (a != 2) && (a % 2 == 0) {
            temp_days2 += 31
        } else if (a > 7) && (a != 2) && (a % 2 != 0){
            temp_days2 += 30
        }
        
    }
    
    total_days2 = (yr2 * 365) + (temp_days2) + (day2)
    
    
    return total_days1 - total_days2
}

