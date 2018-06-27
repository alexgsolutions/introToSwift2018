//
//  AppConfig.swift
//  FinalProyect
//
//  Created by Alexis Gonzalez on 5/18/18.
//  Copyright © 2018 alexgsolutions. All rights reserved.
//https://www.uplabs.com/posts/city-finding-app

import Foundation
import UIKit

enum AppConfig {
    static let appName = "Cuarteles"
    static var ThemeColor: UIColor {
        return UIColor.white
    }
    static var ThemeFontColor: UIColor {
        return UIColor(red: 28.0/255.0, green: 68.0/255.0, blue: 123.0/255.0, alpha: 1.0)
    }
    enum ScreenIdentifiers {
        static let main = ""
        static let placeDetail = "placedetail"
        static let placesMap = "placesmap"
        static let addNewEntity = "addnewentity"
    }
    enum ScreenTitlesNames {
        static let mainScreen = AppConfig.appName
        static let placeDetail = "Detalles"
        static let placesMap = "Lugares"
        static let favorites = "Favoritos"
        static let moreInfo = "Información"
        static let addNewEntity  = "Nueva Entidad"
    }
}

let cityArray = ["Aibonito","Barranquitas","Naranjito"]

