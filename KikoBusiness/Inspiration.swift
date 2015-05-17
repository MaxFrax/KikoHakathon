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
    let imageFileLocal : String
    var ingredientsList : [Ingredient] = []
    
    init (json: NSDictionary) {
        imageFile = json["filename"] as! String
        imageFileLocal = json["filenamelocal"] as! String
        let ingr_array = json["ingredient"] as! NSArray
        for ingredient_index in 0...(ingr_array.count - 1) {
            let json_ingredient : NSDictionary = ingr_array[ingredient_index] as! NSDictionary
            var ingrediente = Ingredient(ingredientImage: json_ingredient["image"] as! String, ingredientTitle: json_ingredient["title"] as! String, ingredientDescription: json_ingredient["description"] as! String)
            ingredientsList.append(ingrediente)
        }
    }
    
    
}