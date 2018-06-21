//
//  PlaceDetailMapView.swift
//  FinalProyect
//
//  Created by Alexis Gonzalez on 5/25/18.
//  Copyright © 2018 alexgsolutions. All rights reserved.
//

import UIKit

protocol PlaceDetailMapViewDelegate: class {
    func detailsRequestedForPlace(place: Places)
}
class PlaceDetailMapView: UIView {

   
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailSubTitleLabel: UILabel!
    @IBOutlet weak var detailCityLabel: UILabel!
    @IBOutlet weak var detailRegionLabel: UILabel!
    
    // data
    var place: Places!
    weak var delegate: PlaceDetailMapViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.layer.borderColor = UIColor.white.cgColor
//        self.layer.borderWidth = 2
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
    }
    
    @IBAction func seeDetails(_ sender: Any) {
        delegate?.detailsRequestedForPlace(place: place)
    }
    
    func configureWithPlace(place: Places) {
        self.place = place
        
        detailTitleLabel.text = place.edificios
        detailRegionLabel.text = place.regi_n?.fixToCamelCase
        detailCityLabel.text = place.municipio?.fixToCamelCase
        
    }
    
}
