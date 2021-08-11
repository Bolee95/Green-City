//
//  MapViewModel.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/19/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation
import Alamofire
import SwiftyJSON

class MapViewModel : UIViewController,CLLocationManagerDelegate, NetworkResponseProtocol
{
    var mapViewHolder : MapView!
    var actions = [ActionModel]()
    var locationManager = CLLocationManager()
    let regionRadius : CLLocationDistance = 2000
    
    
    //MARK : Reading Actions from blockchain and setting markers on map on success
    func loadLocations()
    {
        Alamofire.SessionManager.default.request(ActionRouter.getActions()).responseJSON {response in
            var message : String?
            
            switch(response.result) {
            case .success( _):
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 200:
                        print(response.result.value)
                        let jsonVar = JSON(response.result.value!)
                        self.onSuccess(response: jsonVar,option: nil)
                        
                    case 401:
                        print(response.result.debugDescription)
                    case 422:
                        print(response.result.debugDescription)
                    case 400:
                        print(response.result.debugDescription)
                    case 500:
                        print(response.result.debugDescription)
                    default:
                        break
                    }
                }
            case .failure(let error):
                message = error.localizedDescription
            }
            if (message != nil)
            {
                print(message!)
            }
        }
    }
    
    //MARK : First function to be called when map is loaded
    func checkIfLocationServiceEnabled()
    {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        if let location = locationManager.location
        {
            centerMapOnLocation(location: location)
        }
        loadLocations()
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        loadLocations()
        if let location = locationManager.location
        {
            centerMapOnLocation(location: location)
        }
    }
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapViewHolder.mapView.showsUserLocation = true
            checkIfLocationServiceEnabled()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius, regionRadius)
        mapViewHolder.mapView.setRegion(coordinateRegion, animated: true)
        mapViewHolder.mapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        mapViewHolder.mapView.showsUserLocation = true
        checkIfLocationServiceEnabled()
        if let location = locationManager.location
        {
            centerMapOnLocation(location: location)
        }
    }
    
    
    func onSuccess(response: JSON, option: Int?) {
        let arrayOfActions = response.arrayValue
        for action in arrayOfActions
        {
            let temp = ActionModel(JSONString: action.rawString()!)!
            actions.append(temp)
            let annotation = MapPin(title: temp.name!, coordinate: CLLocationCoordinate2D(latitude: Double(temp.latitude!),longitude: Double(temp.longitude!)), desc: temp.description!)
            mapViewHolder.mapView.addAnnotation(annotation)
        }
    }
    
    func onFailure(error: String, option: Int?) {
        print("Greska pri pozivu!")
    }
    
    
    
    
}
