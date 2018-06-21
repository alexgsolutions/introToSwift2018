//
//  Utils.swift
//  FinalProyect
//
//  Created by Alexis Gonzalez on 5/19/18.
//  Copyright © 2018 alexgsolutions. All rights reserved.
//

import Foundation

func saveToFavoritePlaces(_ selectedPlace: [Places]) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(selectedPlace) {
        let defaults = UserDefaults.standard
        defaults.set(encoded, forKey: "favoritePlaces")
    }
}

func retriveFavoritePlaces() ->[Places] {
    let defaults = UserDefaults.standard
    if let savedPlace = defaults.object(forKey: "favoritePlaces") as? Data {
        let decoder = JSONDecoder()
        if let loadedPlaces = try? decoder.decode([Places].self, from: savedPlace) {
            return loadedPlaces
        }
    }
    return [Places]()
}

func convertStringToThounsand(_ stringNumber: String)->String {
    var amound: NSNumber = 0
    
    if let myInteger = Int(stringNumber) {
        amound = NSNumber(value:myInteger)
    }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = Locale.current.groupingSeparator
         return formatter.string(for: amound)!
}
