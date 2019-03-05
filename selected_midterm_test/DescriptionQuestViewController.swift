//
//  DescriptionQuestViewController.swift
//  selected_midterm_test
//
//  Created by Admin on 5/3/2562 BE.
//  Copyright © 2562 KMUTNB. All rights reserved.
//

import UIKit
import SQLite3
class DescriptionQuestViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
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
        
        sql = "INSERT INTO Quest (id, product, place, date, feeling) VALUES ('1', 'สบู่อาบน้ำ' , 'โรบินสันปราจีนบุรี','22/02/2561','ดีมาก')"
        sqlite3_exec(db,sql,nil,nil,nil)
        
        select()
    }
    
    func select() {
        sql = "SELECT * FROM Quest"
        sqlite3_prepare(db, sql, -1, &pointer, nil)
        textView.text = ""
        
        var id: Int32
        var name: String
        var ages: String
        var birth: String
        var product: String
        
        while(sqlite3_step(pointer) == SQLITE_ROW)
        {
            id = sqlite3_column_int(pointer, 0)
            textView.text?.append("\n รหัสสินค้า: \(id)\n")
            
            name = String(cString: sqlite3_column_text(pointer, 1))
            textView.text?.append("ผลิตภัณฑ์: \(name) \n")
            
            ages = String(cString: sqlite3_column_text(pointer, 2))
            textView.text?.append("สถานที่: \(ages)\n")
            
            birth = String(cString: sqlite3_column_text(pointer, 3))
            textView.text?.append("วันที่: \(birth)\n")
            
            product = String(cString: sqlite3_column_text(pointer, 4))
            textView.text?.append("ความรู้สึก: \(product)\n ---------------------------")
        }
    }
}
