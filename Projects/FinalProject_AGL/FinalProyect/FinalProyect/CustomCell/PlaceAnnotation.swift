//
//  PlaceAnnotation.swift
//  FinalProyect
//
//  Created by Alexis Gonzalez on 5/25/18.
//  Copyright © 2018 alexgsolutions. All rights reserved.
//

import Foundation
import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String
    let city: String
    let region: String
    let coordinate: CLLocationCoordinate2D
    let place: Places
    
    init(place: Places) {
        var lat: Double = 0.0
        var lon: Double = 0.0
        
        if let myPlaceLat = place.latitud  {
            lat = Double(myPlaceLat)!
        }else {
            lat = 18.2363666628
        }
        if let myPlaceLon = place.longitud {
            lon = Double(myPlaceLon)!
        }else {
            lon = -66.0293501021
        }
        let location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: lon
        )
        
        self.title = place.edificios
        self.locationName = place.direcci_n_f_sica!
        self.coordinate = location
        self.city = place.municipio!
        self.region = place.regi_n!
        self.place = place
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
    
}
