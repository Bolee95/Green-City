//
//  MapView.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/19/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapView: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var mapViewModel = MapViewModel()
    var clickedActionName : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapViewModel.mapViewHolder = self
        mapViewModel.locationManager.delegate = mapViewModel
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mapViewModel.checkLocationAuthorizationStatus()
        if let location = mapViewModel.locationManager.location
        {
            mapViewModel.centerMapOnLocation(location: location )
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapViewModel.locationManager.startUpdatingLocation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mapViewModel.locationManager.stopUpdatingLocation()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotationTitle = view.annotation?.title
        {
            self.clickedActionName = annotationTitle!
            performSegue(withIdentifier: "fromMapToProfileSegue", sender: self)
            print("User tapped on annotation with title: \(annotationTitle!)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? ActionDetailsView
        {
            destVC.actionNameString = clickedActionName
        }
    }
}
