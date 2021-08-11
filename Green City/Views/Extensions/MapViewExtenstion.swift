//
//  MapViewExtenction.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/19/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

extension MapView
{
    
    
//    func checkIfLocationServiceEnabled()
//    {
//        //mapView.delegate = self
//        //locationManager.delegate = selvar
//        locationManager = CLLocationManager()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestAlwaysAuthorization()
//        locationManager.startUpdatingLocation()
//        //locationManager.requestAlwaysAuthorization()
//        locationManager.requestWhenInUseAuthorization()
//    }
//    
//    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
//        mapViewModel.loadLocations()
//        if let location = locationManager.location
//        {
//            centerMapOnLocation(location: location)
//        }
//    }
//    
//    func checkLocationAuthorizationStatus() {
//        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
//            mapView.showsUserLocation = true
//            checkIfLocationServiceEnabled()
//        } else {
//            locationManager.requestWhenInUseAuthorization()
//        }
//    }
//    
//    
//    func centerMapOnLocation(location: CLLocation) {
//        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius, regionRadius)
//    mapView.setRegion(coordinateRegion, animated: true)
//        mapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location = locations.last as! CLLocation
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//        
//        //mapView.setRegion(region, animated: true)
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        //if CLAuthorizationStatus.RawValue.self as! Int != 0
//        //{
//            mapView.showsUserLocation = true
//            checkIfLocationServiceEnabled()
//        //}
//    }

}
