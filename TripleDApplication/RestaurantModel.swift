//
//  RestaurantModel.swift
//  TripleDApplication
//
//  Created by Daniela Alvarez  on 4/18/18.
//  Copyright © 2018 Daniela Alvarez Ulloa. All rights reserved.
//

import Foundation

class RestaurantModel {
    
    let name:String
    let descrip:String
    let coordinates:String
    var latitude:Double
    var longitude:Double
    

    init(name: String,descrip: String, coordinates: String, latitude: Double, longitude: Double) {
        self.name = name
        self.descrip = descrip
        self.coordinates = coordinates
        self.latitude = latitude
        self.longitude = longitude
       
        
    }
    
}

