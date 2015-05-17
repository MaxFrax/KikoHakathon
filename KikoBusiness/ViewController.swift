//
//  ViewController.swift
//  KikoBusiness
//
//  Created by Massimo Frasson on 16/05/15.
//  Copyright (c) 2015 Massimo Frasson. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // @IBOutlet weak var makeUpGif: UIImageView!
    // @IBOutlet weak var lblMinor: UILabel!
    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    struct section {
        var beacon : CLBeacon
        var initialDate : NSDate
        var finalDate : NSDate
        
        init(beacon : CLBeacon){
            self.beacon = beacon
            self.initialDate = NSDate()
            self.finalDate = NSDate()
        }
    }
    
    // fake section list
    var storeSectionList : [StoreSection] = []
    var currStoreIndex = 0
    var currInspiration : Inspiration!
    
    var currentSection : section!
    var currentImage : String!
    
    var sectionList : [section] = []
    let currentSectionId = 1
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "ACFD065E-C3C0-11E3-9BBE-1A514932AC01"), identifier: "0")
    
    private let reuseIdentifier = "KikoCellIdentifier"
    private let itemSegueIdentifier = "showCellDetail"
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set collection view
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        //assegno delegato location manager
        locationManager.delegate = self
        
        //chiedo autorizzazione utilizzo posizione utente
        if(CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedAlways){
            locationManager.requestAlwaysAuthorization()
        }
        
        //avviamo la magia
        locationManager.startRangingBeaconsInRegion(region)
        
        var section_1 = StoreSection(sector_index : 1)
        storeSectionList.append(section_1)
        var section_2 = StoreSection(sector_index : 2)
        storeSectionList.append(section_2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        
        // guardiamo tutti i beacon visibili
        for b in beacons as! [CLBeacon]! {
            if(currentSection != nil && currentSection.beacon.minor == b.minor && b.proximity != currentSection.beacon.proximity){
                currentSection.finalDate = NSDate()
                sectionList.append(currentSection)
                //sparo al web
                var d1 = round(currentSection.initialDate.timeIntervalSince1970)
                var d2 = round(currentSection.finalDate.timeIntervalSince1970)
                
                let url = NSURL(string: "http://publisherls.altervista.org/save.php?id=\(currentSection.beacon.minor)&d1=\(d1)&d2=\(d2)")
                
                let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
                    println(NSString(data: data, encoding: NSUTF8StringEncoding))
                }
                
                task.resume()
                currentSection = nil
            }
            // quando ne troviamo uno near
            if(b.proximity == CLProximity.Near){
                if(currentSection == nil){
                    currentSection = section(beacon: b)
                } else if (currentSection.beacon.minor != b.minor) {
                    currentSection = section(beacon: b)
                }
            }
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! KikoCollectionViewCell
        cell.backgroundColor = UIColor.blackColor()
        let curr = indexPath.item
        let currStore : StoreSection = storeSectionList[currStoreIndex]
        let currInsp : Inspiration = currStore.inspirationList[curr]
        cell.cellImage.image = UIImage(named: currInsp.imageFile)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        currInspiration = storeSectionList[currStoreIndex].inspirationList[indexPath.item]
        performSegueWithIdentifier(itemSegueIdentifier, sender: self)
    }
    
    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
            let cell_width = self.view.bounds.width/2
            return CGSize(width: cell_width-15, height: cell_width-15)
    }
    
    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == itemSegueIdentifier {
            if let destination = segue.destinationViewController as? SingleItemViewController {
                //destination image view
                destination.imageInspiration = currInspiration
            }
        }
    }
    
    func switchSection() {
        if (currStoreIndex == 0) {
            currStoreIndex = 1
            collectionView.reloadData()
        }
        else if (currStoreIndex == 1) {
            currStoreIndex = 0
        }
    }
}

