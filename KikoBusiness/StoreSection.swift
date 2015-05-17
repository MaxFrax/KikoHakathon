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
    
    init(sector_index : Int) {
        for loop_index in 1...4 {
            var insp = Inspiration(sector : sector_index, index : loop_index)
            inspirationList.append(insp)
        }
    }
}