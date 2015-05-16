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
    
    var currentSection : section!
    var currentImage : String!
    
    var sectionList : [section] = []
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "ACFD065E-C3C0-11E3-9BBE-1A514932AC01"), identifier: "0")
    
    private let reuseIdentifier = "KikoCellIdentifier"
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 0.0, right: 10.0)

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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {

        // guardiamo tutti i beacon visibili
        for b in beacons as! [CLBeacon]! {
            // quando ne troviamo uno near
            if(b.proximity == CLProximity.Near){
                //salvare roba
                if (currentSection == nil) {
                    //salva prima sezione visitata
                    currentSection = section(beacon: b)
                    sectionList.append(currentSection)
                    //switchImages()
                    //lblMinor.text = "\(currentSection.beacon.minor) \(currentSection.beacon.accuracy)"
                }
                else if(currentSection.beacon.minor != b.minor && currentSection.beacon.accuracy > b.accuracy){
                    currentSection.finalDate = NSDate()                    
                    if (currentSection.finalDate.timeIntervalSinceDate(currentSection.initialDate) > 1) {
                        //switchImages()
                        sectionList.append(currentSection)
                    }
                    currentSection = section(beacon: b)
                }
            }
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
        cell.backgroundColor = UIColor.blackColor()
        return cell
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


    
    /*func switchImages() {
        // no image displayed
        if (currentImage == nil) {
            currentImage = "img1.gif"
        }
        // switch between two images
        else {
            if(currentImage == "img1.gif") {
                currentImage = "img2.gif"
            }
            else {
                currentImage = "img1.gif"
            }
        }
        makeUpGif.image = UIImage(named: currentImage)
        self.reloadInputViews()
    }*/

}

