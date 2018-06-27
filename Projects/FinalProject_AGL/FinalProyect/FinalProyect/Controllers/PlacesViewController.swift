//
//  FirstViewController.swift
//  FinalProyect
//
//  Created by Alexis Gonzalez on 5/18/18.
//  Copyright © 2018 alexgsolutions. All rights reserved.
//

import UIKit

class PlacesViewController: UITableViewController {

    let queryService = QueryService()
    let appData = AppData.shared
    var availablePlaces: [Places] {
        return appData.placesList
    }
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       title = AppConfig.appName
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Mapa", style: .done, target: self, action: #selector(showMap))
        configureBackButton()
        configureLeftButtonStyle()
        setUpRefreshControl()
        applyNavigationShadow()
       
         //Load First data from Query Service
        loadData()
    }
    
    private func setUpRefreshControl() {
         self.refreshControl = UIRefreshControl()
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl!)
        }
        // Configure Refresh Control
        self.refreshControl?.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        refreshControl?.tintColor = AppConfig.ThemeFontColor
        //refreshControl.attributedTitle = NSAttributedString(string: "Fetching Data ...", attributes: attribute_set)
        refreshControl?.attributedTitle = NSAttributedString(string: "Buscando Data ...")
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        loadData()
        self.refreshControl?.endRefreshing()
        
    }
    
   @objc private func showMap() {
        let placesMapVC = storyboard?.instantiateViewController(withIdentifier: AppConfig.ScreenIdentifiers.placesMap) as? PlacesMapViewController
        placesMapVC?.placesList = availablePlaces
        navigationController?.pushViewController(placesMapVC!, animated: true)
    }

    private func loadData() {
        queryService.getAllPlaces { [weak self] (_, _) in
           self?.tableView.reloadData()
        }
    }
}

extension PlacesViewController {
    
    override  func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availablePlaces.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "places", for: indexPath) as! PlaceCell
        let place = availablePlaces[indexPath.row]
        cell.buildingNameLabel.text = place.edificios
        cell.cityNameLabel.text = place.municipio?.fixToCamelCase
        cell.regionNameLabel.text = place.regi_n?.fixToCamelCase
        
        return cell
    }
}

extension PlacesViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: AppConfig.ScreenIdentifiers.placeDetail) as? PlaceDetailViewController
        detailVC?.place = availablePlaces[indexPath.row]
        navigationController?.pushViewController(detailVC!, animated: true)
    }
}


