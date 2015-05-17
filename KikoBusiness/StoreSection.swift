//
//  StoreSection.swift
//  KikoBusiness
//
//  Created by Leonardo Lanzinger on 17/05/15.
//  Copyright (c) 2015 Massimo Frasson. All rights reserved.
//

import Foundation

class StoreSection : NSObject {
    
    var inspirationList : [Inspiration] = []
    
    init( json: NSArray) {
        for loop_index in 0...(json.count-1) {
            var insp = Inspiration(json : json[loop_index] as! NSDictionary)
            inspirationList.append(insp)
        }
        
    }
}