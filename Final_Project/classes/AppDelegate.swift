//
//  AppDelegate.swift
//  Final_Project
//
//  Created by Dhruvil Patel on 2020-04-18.
//  Copyright © 2020 Dhruvil Patel. All rights reserved.
//

import UIKit
import Firebase
import SQLite3

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var userId = ""
    var databaseName: String? = "FinalProject.db"
    var databasePath: String?
    var dataObj: [DataObj] = []
    //var searchUid = ""


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDir = documentPaths[0]
        databasePath = documentDir.appending("/"+databaseName!)
        checkAndCreateDatabase()
//        readDataFromDatabase(uid: searchUid)
        readDataFromDatabase()
        return true
    }
    
    func readDataFromDatabase(){
        dataObj.removeAll()
        var db: OpaquePointer? = nil
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK{
            print("Successfully opned connection to database at \(self.databasePath)")
            
            var queryStatment : OpaquePointer? = nil
            let queryStatmentString : String = "select * from reminders where uid = ?"
            if sqlite3_prepare_v2(db, queryStatmentString, -1, &queryStatment, nil) == SQLITE_OK{
                while sqlite3_step(queryStatment) == SQLITE_ROW{
                    let id : Int = Int(sqlite3_column_int(queryStatment, 0))
                    let cdesc = sqlite3_column_text(queryStatment, 1)
                    let ctype = sqlite3_column_text(queryStatment, 2)
                    let cdate = sqlite3_column_text(queryStatment, 3)
                    let cuid = sqlite3_column_text(queryStatment, 4)
                    //let wUid = uid as NSString
                   // sqlite3_bind_text(queryStatmentString, 1, wUid.utf8String, -1, nil)
                    
                    
                    let desc = String(cString: cdesc!)
                    let type = String(cString: ctype!)
                    let date = String(cString: cdate!)
                    let uid = String(cString: cuid!)
                    
                    let data : DataObj = DataObj.init()
                    
                    data.initWithData(theRow: id, theDesc: desc, theType: type, theDate: date, theUid: uid)
                    dataObj.append(data)
                    print("Query result")
                    print("\(id) | \(desc) | \(type) | \(date) | \(uid)")
                    
                }
                sqlite3_finalize(queryStatment)
            }else{
                print("Select statment could not be prepared")
            }
            sqlite3_close(db)
        }else{
            print("Unable to connect database")
        }
    }
    
    func checkAndCreateDatabase(){
        var success = false
        let fileManager = FileManager.default
        success = fileManager.fileExists(atPath: databasePath!)
        
        if success{
            return
        }
        let databasePathFromApp = Bundle.main.resourcePath?.appending("/"+databaseName!)
        try? fileManager.copyItem(atPath: databasePathFromApp!, toPath: databasePath!)
        return
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

