//
//  StatesModel.swift
//  Homework8_Class
//
//  Created by Alexis Gonzalez on 5/11/18.
//  Copyright © 2018 io.ricoLabs. All rights reserved.
//

import Foundation
import UIKit


func saveCreditCards(_ creditCards: [CreditCard]) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(creditCards) {
        let defaults = UserDefaults.standard
        defaults.set(encoded, forKey: "appCreditCard")
    }
}

func retriveCreditCards() ->[CreditCard] {
    let defaults = UserDefaults.standard
    if let savedCards = defaults.object(forKey: "appCreditCard") as? Data {
        let decoder = JSONDecoder()
        if let loadedCards = try? decoder.decode([CreditCard].self, from: savedCards) {
            return loadedCards
        }
    }
    return [CreditCard]()
}

func getCardImage(_ cardNumber: String) -> UIImage? {
    let prefix = cardNumber.prefix(1)
    switch prefix {
    case "3":
        return #imageLiteral(resourceName: "amex48")
    case "4":
         return #imageLiteral(resourceName: "visa48")
    case "5":
         return #imageLiteral(resourceName: "mastercard48")
    default:
        return #imageLiteral(resourceName: "credit-card-48")
    }
}

func cardImage(forState cardState:CardState) -> UIImage? {
    switch cardState {
    case .identified(let cardType):
        switch cardType {
        case .visa:         return #imageLiteral(resourceName: "visa48")
        case .masterCard:   return #imageLiteral(resourceName: "mastercard48")
        case .amex:         return #imageLiteral(resourceName: "amex48")
        case .discover:     return #imageLiteral(resourceName: "discover48")
        case .diners:
            return #imageLiteral(resourceName: "credit-card-48")
        case .jcb:
            return #imageLiteral(resourceName: "credit-card-48")
        }
    case .indeterminate: return #imageLiteral(resourceName: "credit-card-48")
    case .invalid:      return #imageLiteral(resourceName: "credit-card-48")
    }
}
public func getYearsForPicker() ->[Int] {
    var years: [Int] = []
    if years.count == 0 {
        var year = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.year, from: NSDate() as Date)
        for _ in 1...15 {
            years.append(year)
            year += 1
        }
    }
    return years
}

public func getMonthForPicker() ->[String] {
   
    return ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
}

let statesArray = ["Alaska",
              "Alabama",
              "Arkansas",
              "American Samoa",
              "Arizona",
              "California",
              "Colorado",
              "Connecticut",
              "District of Columbia",
              "Delaware",
              "Florida",
              "Georgia",
              "Guam",
              "Hawaii",
              "Iowa",
              "Idaho",
              "Illinois",
              "Indiana",
              "Kansas",
              "Kentucky",
              "Louisiana",
              "Massachusetts",
              "Maryland",
              "Maine",
              "Michigan",
              "Minnesota",
              "Missouri",
              "Mississippi",
              "Montana",
              "North Carolina",
              " North Dakota",
              "Nebraska",
              "New Hampshire",
              "New Jersey",
              "New Mexico",
              "Nevada",
              "New York",
              "Ohio",
              "Oklahoma",
              "Oregon",
              "Pennsylvania",
              "Puerto Rico",
              "Rhode Island",
              "South Carolina",
              "South Dakota",
              "Tennessee",
              "Texas",
              "Utah",
              "Virginia",
              "Virgin Islands",
              "Vermont",
              "Washington",
              "Wisconsin",
              "West Virginia",
              "Wyoming"]
