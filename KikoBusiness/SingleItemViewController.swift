//
//  SingleItemViewController.swift
//  KikoBusiness
//
//  Created by Leonardo Lanzinger on 16/05/15.
//  Copyright (c) 2015 Massimo Frasson. All rights reserved.
//

import UIKit

class SingleItemViewController: UIViewController {
    
    @IBOutlet weak var imageSingleView: UIImageView!

    var imageInspiration : Inspiration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageSingleView.image = UIImage(named: imageInspiration.imageFile)
        self.reloadInputViews()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
