//
//  Inspiration.swift
//  KikoBusiness
//
//  Created by Leonardo Lanzinger on 17/05/15.
//  Copyright (c) 2015 Massimo Frasson. All rights reserved.
//

import Foundation

class Inspiration : NSObject {

    let imageFile : String
    
    init (sector: Int, index: Int) {
        imageFile = "section-\(sector)/img\(index).gif"
    }
    
    
}