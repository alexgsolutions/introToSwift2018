//
//  SecondViewController.swift
//  FinalProyect
//
//  Created by Alexis Gonzalez on 5/18/18.
//  Copyright © 2018 alexgsolutions. All rights reserved.
//

import UIKit

class FavoriteViewController: UITableViewController {

    var favoritesPlaces = [Places]()
    var emptyView: EmptyView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       title = AppConfig.ScreenTitlesNames.favorites
        configureBackButton()
         applyNavigationShadow()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        configureBackButton()
        configureLeftButtonStyle()
        configureRightButtonStyle()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadFavoritesData()
    }
    
    private func loadFavoritesData() {
        favoritesPlaces = retriveFavoritePlaces()
        
        if favoritesPlaces.count == 0 {
            showEmptyView()
        }else {
            hideEmptyView()
        }
        tableView.reloadData()
    }

   
    
    // MARK: empty view methods
    func showEmptyView() {
        emptyView = EmptyView()
        emptyView.emptyMessageLabel.text = "Esta muy solo por aquí. Puedes añadir lugares marcando el corazón en la pantalla de detalles."
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
    
}

//MARK: TableViewv-DataSource
extension FavoriteViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesPlaces.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesplaces", for: indexPath) as! PlaceCell
        
        let place = favoritesPlaces[indexPath.row]
        cell.buildingNameLabel.text = place.edificios
        cell.cityNameLabel.text = place.municipio
        cell.regionNameLabel.text = place.regi_n
        
        return cell
    }
}
//MARK: TableViewv-Delegate
extension FavoriteViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: AppConfig.ScreenIdentifiers.placeDetail) as? PlaceDetailViewController
        detailVC?.place = favoritesPlaces[indexPath.row]
        navigationController?.pushViewController(detailVC!, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
  override  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            self.deleteEntity(indexPath)
        }
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.favoritesPlaces[sourceIndexPath.row]
        favoritesPlaces.remove(at: sourceIndexPath.row)
        favoritesPlaces.insert(movedObject, at: destinationIndexPath.row)
        saveToFavoritePlaces(favoritesPlaces)
        NSLog("%@", "\(sourceIndexPath.row) => \(destinationIndexPath.row) \(favoritesPlaces)")
        // To check for correctness enable: self.tableView.reloadData()
    }
    
    private func deleteEntity(_ index: IndexPath) {
        let place = favoritesPlaces[index.row]
        
        let alertController = UIAlertController(title: AppConfig.appName, message: "¿Borrar \(place.edificios ?? "esta entidad")?", preferredStyle: .actionSheet)
        
        let delete = UIAlertAction(title: "Borrar", style: .destructive) { (action:UIAlertAction) in
            print("You've pressed default");
            self.favoritesPlaces.remove(at: index.row)
            saveToFavoritePlaces(self.favoritesPlaces)
            self.loadFavoritesData()
        }
        
        let cancel = UIAlertAction(title: "Cancelar", style: .default) { (action:UIAlertAction) in
            print("You've pressed cancel");
        }
        
        alertController.addAction(delete)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
}

