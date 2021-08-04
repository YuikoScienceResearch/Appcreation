//
//  GoogleMapViewController.swift
//  ScienceResearchApp
//
//  Created by Yuiko Suzuki on 8/3/21.
//

import UIKit
import GoogleMaps
import CoreLocation

class GoogleMapViewController: UIViewController, CLLocationManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let manager = CLLocationManager()
    
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        GMSServices.provideAPIKey("AIzaSyBmVrQAyaovzItknfgimlR4ukqogO3W-uU")
        
            print ("License: \n\n\(GMSServices.openSourceLicenseInfo())")
      
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        let coordinate = location.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 6.0)
             let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
             view.addSubview(mapView)

             let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
             marker.title = "Sydney"
             marker.snippet = "Australia"
             marker.map = mapView
    }
}
