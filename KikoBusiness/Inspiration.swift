//
//  Inspiration.swift
//  KikoBusiness
//
//  Created by Leonardo Lanzinger on 17/05/15.
//  Copyright (c) 2015 Massimo Frasson. All rights reserved.
//

import Foundation

class Inspiration : NSObject {

    struct Ingredient {
        let ingredientImage : String
        let ingredientTitle : String
        let ingredientDescription : String
    }
    
    let imageFile : String
    var ingredientsList : [Ingredient] = []
    
    init (sector: Int, index: Int) {
        imageFile = "section-\(sector)/img\(index).gif"
        var fake_ing = Ingredient(ingredientImage: imageFile, ingredientTitle: "Titolo", ingredientDescription: "Descrizione molto lunga")
        ingredientsList.append(fake_ing)
    }
    
    
}