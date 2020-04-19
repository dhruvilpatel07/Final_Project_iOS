//
//  DataObj.swift
//  Final_Project
//
//  Created by Xcode User on 2020-04-18.
//  Copyright © 2020 Dhruvil Patel. All rights reserved.
//

import UIKit

class DataObj: NSObject {

    var id : Int?
    var desc : String?
    var type : String?
    var date : String?
    var uid : String?
    
    func initWithData(theRow i:Int , theDesc de : String, theType ty : String, theDate da : String, theUid u : String )
    {
        id = i
        desc = de
        type = ty
        date = da
        uid = u
        
    }
}

