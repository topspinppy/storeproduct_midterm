//
//  ViewController.swift
//  selected_midterm_test
//
//  Created by Admin on 5/3/2562 BE.
//  Copyright © 2562 KMUTNB. All rights reserved.
//

import UIKit
import SQLite3

class ViewController: UIViewController {
    
    @IBOutlet weak var product: UITextField!
    @IBOutlet weak var place: UITextField!
    @IBOutlet weak var datesave: UIDatePicker!
    
    
    @IBOutlet weak var happy: UIButton!
    @IBOutlet weak var nothing: UIButton!
    @IBOutlet weak var unhappy: UIButton!
    
    let fileName = "db.sqlite"
    let fileManager = FileManager.default
    var dbPath = String()
    var sql = String()
    var db: OpaquePointer?
    var stmt: OpaquePointer?
    var pointer: OpaquePointer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dbURL = try! fileManager.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false)
            .appendingPathComponent(fileName)
        let openDb = sqlite3_open(dbURL.path, &db)
        if openDb != SQLITE_OK{
            print("opening database error!")
            return
        }

        sql = "CREATE TABLE IF NOT EXISTS Quest (id INTEGER PRIMARY KEY AUTOINCREMENT, product TEXT, place TEXT, date TEXT, feeling TEXT)"

        let createTb = sqlite3_exec(db, sql, nil, nil, nil)
        if createTb != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print(err)
        }
    }
    
    @IBAction func handleHappy(_ sender: Any) {
        let products = product.text! as NSString
        let places = place.text! as NSString
        
        let currentDate = datesave.date
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "dd/MM/YYYY"
        let thaiLocale = NSLocale(localeIdentifier: "TH_th")
        myFormatter.locale = thaiLocale as Locale
        let currentDateText = myFormatter.string(from: currentDate)

        
        self.sql = "INSERT INTO Quest VALUES (null,?,?,?,'มีความสุข')";
        sqlite3_prepare(self.db, self.sql, -1, &self.stmt, nil)
        
        sqlite3_bind_text(self.stmt, 1, products.utf8String, -1, nil)
        sqlite3_bind_text(self.stmt, 2, places.utf8String , -1, nil)
        sqlite3_bind_text(self.stmt, 3, currentDateText, -1, nil)
        sqlite3_step(self.stmt)
        
    }
    
    @IBAction func handleNothing(_ sender: Any) {
        let products = product.text! as NSString
        let places = place.text! as NSString
        
        let currentDate = datesave.date
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "dd/MM/YYYY"
        let thaiLocale = NSLocale(localeIdentifier: "TH_th")
        myFormatter.locale = thaiLocale as Locale
        let currentDateText = myFormatter.string(from: currentDate)
        
        
        self.sql = "INSERT INTO Quest VALUES (null,?,?,?,'เฉยๆ')";
        sqlite3_prepare(self.db, self.sql, -1, &self.stmt, nil)
        
        sqlite3_bind_text(self.stmt, 1, products.utf8String, -1, nil)
        sqlite3_bind_text(self.stmt, 2, places.utf8String , -1, nil)
        sqlite3_bind_text(self.stmt, 3, currentDateText, -1, nil)
        sqlite3_step(self.stmt)
        
    }
    
    @IBAction func handleUnhappy(_ sender: Any) {
        let products = product.text! as NSString
        let places = place.text! as NSString
        
        let currentDate = datesave.date
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "dd/MM/YYYY"
        let thaiLocale = NSLocale(localeIdentifier: "TH_th")
        myFormatter.locale = thaiLocale as Locale
        let currentDateText = myFormatter.string(from: currentDate)
        
        
        self.sql = "INSERT INTO Quest VALUES (null,?,?,?,'ไม่มีความสุข')";
        sqlite3_prepare(self.db, self.sql, -1, &self.stmt, nil)
        
        sqlite3_bind_text(self.stmt, 1, products.utf8String, -1, nil)
        sqlite3_bind_text(self.stmt, 2, places.utf8String , -1, nil)
        sqlite3_bind_text(self.stmt, 3, currentDateText, -1, nil)
        sqlite3_step(self.stmt)
    }
    
}

