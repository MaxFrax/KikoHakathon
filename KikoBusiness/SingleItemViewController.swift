//
//  SingleItemViewController.swift
//  KikoBusiness
//
//  Created by Leonardo Lanzinger on 16/05/15.
//  Copyright (c) 2015 Massimo Frasson. All rights reserved.
//

import UIKit

class SingleItemViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var imageSingleView: UIImageView!
    @IBOutlet weak var ingredientTable: UITableView!
    
    var imageInspiration : Inspiration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientTable.delegate = self
        ingredientTable.dataSource = self
        
        imageSingleView.image = UIImage(named: imageInspiration.imageFileLocal)
        //imageSingleView.image = UIImage.animatedImageWithAnimatedGIFURL( NSURL.fileURLWithPath(imageInspiration.imageFile))
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageInspiration.ingredientsList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! IngredientCell
        
        cell.setContents(UIImage(named: imageInspiration.ingredientsList[indexPath.item].ingredientImage)!, name: imageInspiration.ingredientsList[indexPath.item].ingredientTitle, desc: imageInspiration.ingredientsList[indexPath.item].ingredientDescription)
        
        return cell
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
