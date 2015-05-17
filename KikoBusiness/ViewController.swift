//
//  ViewController.swift
//  KikoBusiness
//
//  Created by Massimo Frasson on 16/05/15.
//  Copyright (c) 2015 Massimo Frasson. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var makeUpGif: UIImageView!
    @IBOutlet weak var lblMinor: UILabel!
    @IBOutlet weak var lblDebug: UILabel!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
                    switchImages()
                    sectionList.append(currentSection)
                    lblMinor.text = "\(currentSection.beacon.minor) \(currentSection.beacon.accuracy)"
                } else if(currentSection.beacon.minor != b.minor && currentSection.beacon.accuracy > b.accuracy){
                    currentSection.finalDate = NSDate()
                    var nextCurrent = section(beacon: b)
                    nextCurrent.finalDate = NSDate()
                    if (currentSection.finalDate.timeIntervalSinceDate(currentSection.initialDate) > 1) {
                        switchImages()
                        lblMinor.text = "\(currentSection.beacon.minor) \(currentSection.beacon.accuracy)"
                        currentSection = section(beacon: b)
                        sectionList.append(nextCurrent)
                    }
                    
                    currentSection = nextCurrent
                    
                    //sparo al web
                    var d1 = round(currentSection.initialDate.timeIntervalSince1970)
                    var d2 = round(currentSection.finalDate.timeIntervalSince1970)
                    
                    let url = NSURL(string: "http://publisherls.altervista.org/save.php?id=\(d1)&d1=\(currentSection.initialDate.timeIntervalSince1970)&d2=\(d2)")
                    
                    let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
                        println(NSString(data: data, encoding: NSUTF8StringEncoding))
                    }
                    
                    task.resume()
                }
            }
        }
        
        lblDebug.text = "P: "
        for aSection in sectionList {
            lblDebug.text = "\(lblDebug.text!) \(aSection.beacon.minor)"
        }
    }
    
    func switchImages() {
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
    }
    
}

