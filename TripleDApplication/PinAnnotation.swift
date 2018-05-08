//
//  PinAnnotation.swift
//  TripleDApplication
//
//  Created by Daniela Alvarez  on 4/30/18.
//  Copyright © 2018 Daniela Alvarez Ulloa. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class PinAnnotation: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D){
        self.title = title
        self.coordinate = coordinate
    }
    
    func mapItem() -> MKMapItem {
        //let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
    
    
    
}
//Link to source: https://www.raywenderlich.com/160517/mapkit-tutorial-getting-started
