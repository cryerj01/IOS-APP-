//
//  HomeViewController.swift
//  ios
//
//  Created by Joseph Cryer on 12/03/2020.
//  Copyright © 2020 Joseph Cryer. All rights reserved.
//

import UIKit
import FirebaseAuth
import MapKit
import CoreLocation



class HomeViewController: UIViewController {

    let locManager = CLLocationManager()
    let reginMeters: Double = 10000
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // set initial location in Honolulu
        userCheck()
        checkLocationServices()
        
        
    }
    
    
    func userCheck(){
        if Auth.auth().currentUser == nil {
            transitionToHome()
        }
    }
     func transitionToHome(){
        
        let ViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.ViewControler) as? ViewController
        
        view.window?.rootViewController = ViewController
        view.window?.makeKeyAndVisible()
    }

    

    @IBAction func onClick(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            transitionToHome()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
    
    
    func checkLocationServices(){
        
        if CLLocationManager.locationServicesEnabled() {
            locManager.delegate = self
            locManager.desiredAccuracy = kCLLocationAccuracyBest
            checkLocationAuthorisation()
            
        }else{
            
        }
    }
    func centerVIewOnUserLocation(){
        if let location = locManager.location?.coordinate{
            let regin = MKCoordinateRegion.init(center: location, latitudinalMeters: reginMeters, longitudinalMeters: reginMeters)
            mapView.setRegion(regin, animated: true)
        }
    }
    func checkLocationAuthorisation() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerVIewOnUserLocation()
            locManager.stopUpdatingLocation()
            break
        case .notDetermined:
            locManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            
            break
        case .denied:
            
            break
        case .authorizedAlways:
            break
       
        @unknown default:
        break
         }
    }
    
   
    
}

extension HomeViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let regin = MKCoordinateRegion(center: center,latitudinalMeters: reginMeters, longitudinalMeters: reginMeters)
        mapView.setRegion(regin, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorisation()
    }
    
    
}
