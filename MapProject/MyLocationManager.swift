//
//  MyLocationManager.swift
//  MapProject
//
//  Created by Consultant on 8/2/23.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI

class MyLocationManager: NSObject, ObservableObject{
    
    @Published var yourLocation: CLLocation?
    
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    
    
}

extension MyLocationManager:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else{
            return
            
        }
        yourLocation = location
        print(yourLocation?.coordinate as Any)
    
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension MKCoordinateRegion{
    static func someLocation() -> MKCoordinateRegion{
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 33.7567516044869, longitude: -84.39230537113572), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    }
    
    func getBindingofSomeLocation() -> Binding<MKCoordinateRegion>? {
        return Binding<MKCoordinateRegion>.constant(self)
    }
}
