//
//  AppData.swift
//  FinalProyect
//
//  Created by Alexis Gonzalez on 5/21/18.
//  Copyright © 2018 alexgsolutions. All rights reserved.
//

import Foundation

final class AppData {
    
    static let shared = AppData()
    private init() {}
    private var places: [Places] = []
    private var crimeStatistic: [CrimeStatistic] = []
}

// MARK: - Public getters

extension AppData {
    var placesList: [Places] {
        return places
    }
    var crimeList: [CrimeStatistic] {
        return crimeStatistic
    }
}

extension AppData {
    
    func updatePlacesList(with placesResponse: [Places]?) {
        guard let response = placesResponse else { return }
        self.places = response
    }
    
    func updateCrimeStatisticList(with crimeStatisticResponse: [CrimeStatistic]?) {
        guard let response = crimeStatisticResponse else { return }
        self.crimeStatistic = response
    }
}
