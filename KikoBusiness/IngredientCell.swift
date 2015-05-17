//
//  IngredientCell.swift
//  KikoBusiness
//
//  Created by Leonardo Lanzinger on 17/05/15.
//  Copyright (c) 2015 Massimo Frasson. All rights reserved.
//

import UIKit

class IngredientCell: UITableViewCell {
    
    @IBOutlet weak var labelImage: UIImageView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    
    func setContents(to_put_image : UIImage, name : String, desc : String){
        
        labelTitle.text = name
        labelDescription.text = desc
        labelImage.image = to_put_image
    }
    
}
