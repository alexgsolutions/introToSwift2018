//
//  PlacesMapViewController.swift
//  FinalProyect
//
//  Created by Alexis Gonzalez on 5/27/18.
//  Copyright © 2018 alexgsolutions. All rights reserved.
//https://makeapppie.com/2016/05/16/adding-annotations-and-overlays-to-maps/

import UIKit
import MapKit
import CoreLocation

class PlacesMapViewController: UIViewController {

    var placesList: [Places] = []
    let locationManager: CLLocationManager = CLLocationManager()
   
    //MARK: Global Declarations
    let puertoRicoCoordinate = CLLocationCoordinate2DMake(18.2208, -66.5901)// 0,0 Puerto Rico coordinates
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = AppConfig.ScreenTitlesNames.placesMap
        addPlacesToMap()
        setUpUserLocation()
         applyNavigationShadow()
    }
    
    private func setUpUserLocation() {
        mapView.showsUserLocation = true
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
     //MARK: - Map setup
    private func addPlacesToMap() {
        var annotation: [PlaceAnnotation] = []
        mapView.delegate = self
        
        //Setup Map
        for place in placesList {
            let placeAnnotation = PlaceAnnotation(place: place)
            annotation.append(placeAnnotation)
            mapView.addAnnotations(annotation)
        }
       

    }
    
    func resetRegion(_ location: CLLocation){
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 30000, 30000)
        mapView.setRegion(region, animated: true)
    }

}
extension PlacesMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationcallout")
        
        if annotationView == nil {
            annotationView = PlacesAnnotationView(annotation: annotation, reuseIdentifier: "annotationcallout")
    
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }
}

extension PlacesMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation: CLLocation = locations[locations.count - 1]
        resetRegion(lastLocation)
    }
}
