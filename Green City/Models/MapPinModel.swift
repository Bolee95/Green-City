//
//  MapPinModel.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/19/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation
import MapKit

class MapPin: NSObject,MKAnnotation
{
    let title: String?
    let coordinate: CLLocationCoordinate2D
    let desc : String?
    
    init(title: String, coordinate : CLLocationCoordinate2D, desc: String)
    {
        
        self.title = title
        self.coordinate = coordinate
        self.desc = desc
        super.init()
    }
    
    var subtitle: String? { return desc }
}
