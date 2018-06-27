//
//  PlaceDetailViewController.swift
//  FinalProyect
//
//  Created by Alexis Gonzalez on 5/21/18.
//  Copyright © 2018 alexgsolutions. All rights reserved.
//http://www.stefanovettor.com/2016/04/30/adding-badge-uibarbuttonitem/

import Foundation
import UIKit
import MapKit
import CoreLocation


class PlaceDetailViewController: UIViewController,CAAnimationDelegate {
    
    var place: Places?
    let queryService = QueryService()
    let appData = AppData.shared
    var crimeDataList: [CrimeStatistic] {
        return appData.crimeList
    }
     var emptyView: EmptyView!
    
    
    //Outlet
    
    @IBOutlet weak var buildingAvatarImage: UIImageView! 
    @IBOutlet weak var buildingNameLabel: UILabel!
    @IBOutlet weak var buildingAddressLabel: UILabel!    
    @IBOutlet weak var crimeStatTitleLabel: UILabel!
    @IBOutlet weak var locationMapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var openInMapButton: UIButton! {
        didSet {
            openInMapButton.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = AppConfig.ScreenTitlesNames.placeDetail
        buildingNameLabel.text = "\(place?.edificios ?? "No Data") de \(place?.municipio ?? "")"
        buildingAddressLabel.text = place?.direcci_n_f_sica
        crimeStatTitleLabel.text = "Crimenes total región de \(place?.regi_n?.fixToCamelCase ?? "Puerto Rico")"
        setUpMap()
        loadCrimeData()
        applyNavigationShadow()
        //scrollView.autoresizingMask = UInt8(UIViewAutoresizing.FlexibleWidth.rawValue) | UIViewAutoresizing.FlexibleHeight.rawValue
        
        
        self.view.bringSubview(toFront: buildingAvatarImage)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpFavoriteImage()
    }
    // MARK: empty view methods
    func showEmptyView() {
        emptyView = EmptyView()
        emptyView.emptyMessageLabel.text = "No se encontró data de crimenes para esta región."
        emptyView.tag = 100
        self.tableView.addSubview(emptyView)
    }
    
    func hideEmptyView() {
        print("Start remove subview")
        if let viewWithTag = self.tableView.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
            print("subview removed!!")
        }else{
            print("No!")
        }
    }
    
    private func setUpFavoriteImage() {
    let favoritesPlaces = retriveFavoritePlaces()
        if favoritesPlaces.contains(where: { $0.n_m_aep == place?.n_m_aep }) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "heart-filled"), style: .done, target: self, action: #selector(setFavoritePlace))
        }else {
             navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-heart"), style: .done, target: self, action: #selector(setFavoritePlace))
        }
         configureRightButtonStyle()
    }
    private func loadCrimeData() {
        if let city = place?.regi_n {
            queryService.getCrimeStatisticByPlace(city, completion: { [weak self](_, _) in
                if self?.crimeDataList.count == 0 {
                    self?.showEmptyView()
                }else {
                    self?.hideEmptyView()
                }
                self?.tableView.reloadData()
            })
        }
       
    }
    
    @objc func setFavoritePlace() {
        var favoritesPlaces = retriveFavoritePlaces()
        if favoritesPlaces.contains(where: { $0.n_m_aep == place?.n_m_aep }) {
            favoritesPlaces = favoritesPlaces.filter {$0.n_m_aep != place?.n_m_aep}
             navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-heart"), style: .done, target: self, action: #selector(setFavoritePlace))
        }else {
             favoritesPlaces.append(place!)
             navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "heart-filled"), style: .done, target: self, action: #selector(setFavoritePlace))
        }
        saveToFavoritePlaces(favoritesPlaces)
        runAnimationOnSavePlace()
        configureRightButtonStyle()
    }
    
    private func runAnimationOnSavePlace() {
        
        self.view.bringSubview(toFront: buildingAvatarImage)
        buildingAvatarImage.layer.zPosition = 1
        self.view.layoutIfNeeded()
        
      
        let bezierPath = UIBezierPath()
        bezierPath.move(to: buildingAvatarImage.center)
        bezierPath.addQuadCurve(to: self.tableView.center, controlPoint: CGPoint(x:self.buildingAvatarImage.center.y , y:tableView.center.x ))

        let moveAnim = CAKeyframeAnimation(keyPath: "position")
        moveAnim.path = bezierPath.cgPath
        moveAnim.isRemovedOnCompletion = true

        let scaleAnim = CABasicAnimation(keyPath: "transform")
        scaleAnim.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        scaleAnim.toValue = NSValue(caTransform3D: CATransform3DMakeScale(0.1, 0.1, 1.0))
        scaleAnim.isRemovedOnCompletion = true

        let opacityAnim = CABasicAnimation(keyPath: "alpha")
        opacityAnim.fromValue = NSNumber(value: 1.0)
        opacityAnim.toValue = NSNumber(value: 0.1)
        opacityAnim.isRemovedOnCompletion = true

        let animGroup = CAAnimationGroup()
        animGroup.delegate = self
        animGroup.setValue("curvedAnim", forKey: "animationName")
        animGroup.animations = [moveAnim,scaleAnim,opacityAnim]
        animGroup.duration = 1
        buildingAvatarImage.layer.add(animGroup, forKey: "curvedAnim")
    }
    

     //open Apple Maps
    @IBAction func openInMapButtonPressed(_ sender: Any) {
        
            let latitude: CLLocationDegrees =  Double((place?.latitud)!)!
            let longitude: CLLocationDegrees =  Double((place?.longitud)!)!
            let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            let placemark : MKPlacemark = MKPlacemark(coordinate: coordinate, addressDictionary:nil)
            let mapItem:MKMapItem = MKMapItem(placemark: placemark)
            
            mapItem.name = place?.edificios
            
            let launchOptions:NSDictionary = NSDictionary(object: MKLaunchOptionsDirectionsModeDriving, forKey: MKLaunchOptionsDirectionsModeKey as NSCopying)
            
            let currentLocationMapItem:MKMapItem = MKMapItem.forCurrentLocation()
            
            MKMapItem.openMaps(with: [currentLocationMapItem, mapItem], launchOptions: launchOptions as? [String : Any])
    }
}

//MARK: CoreLocation
extension PlaceDetailViewController : CLLocationManagerDelegate{
    
    private func setUpMap() {
        
        locationMapView.delegate = self
        //Setup Map
        var lat: Double = 0.0
        var lon: Double = 0.0
        if let placeLat = place?.latitud {
            lat = Double(placeLat)!
        }else {
            lat = 18.2363666628
        }
        if let placeLon = place?.longitud {
            lon = Double(placeLon)!
        }else {
            lon = -66.0293501021
        }
        let location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: lon
        )
        
        let region = MKCoordinateRegionMakeWithDistance(location, 5000, 5000)
        locationMapView.setRegion(region, animated: true)
        
        //3
        let annotation = PlaceAnnotation(place: place!)
        locationMapView.addAnnotation(annotation)
    }
}

//MARK: Map Delegates
extension PlaceDetailViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationcallout")
        
        if annotationView == nil {
            annotationView = PlacesAnnotationView(annotation: annotation, reuseIdentifier: "annotationcallout")
            //(annotationView as! PlacesAnnotationView)
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }
    
}

extension PlaceDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return crimeDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "crimecell", for: indexPath) as? CrimeCell
        let crimeData = crimeDataList[indexPath.row]
        
        cell?.crimeNameLabel.text = crimeData.delitosCode
        cell?.crimeTotalLabel.text = convertStringToThounsand(crimeData.count!)
        
        return cell!
    }
}
extension PlaceDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

