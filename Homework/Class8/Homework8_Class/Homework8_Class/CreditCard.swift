//
//  CreditCard.swift
//  Homework8_KL
//
//  Created by Kevin Lopez on 5/1/18.
//  Copyright © 2018 io.ricoLabs. All rights reserved.
//

import Foundation

struct CreditCard: Codable {
    var firstName: String = ""
    var lastName: String = ""
    var cardNumber: String = ""
    var expirationDate: String = ""
    var securityCode: String = ""
    var address: Address = Address()
}

extension CreditCard {
    
    var getFullName: String {
        return "\(firstName) \(lastName)"
    }
   
    var getLastFourDigitFormat: String {
        return "\(cardNumber.suffix(4))"
    }
    var getFirstFourDigit: String {
        return "\(cardNumber)"
    }
   
    var getCreditCarInfo: String {
        return "***\(getLastFourDigitFormat), expires \(expirationDate)"
    }
    var isDetailsFilledOut: Bool {
        return !firstName.isEmpty && !expirationDate.isEmpty && !securityCode.isEmpty
    }

    mutating func updateCardDetail(_ type: CardDetailSectionCellType, _ value: String) -> CreditCard {
        switch type {
        case .firstName:
            self.firstName = value
        case .lastName:
            self.lastName = value
        case .cardNumber:
            self.cardNumber = value
        case .expirationDate:
            self.expirationDate = value
        case .securityCode:
            self.securityCode = value
        }
        return self
    }
    
    mutating func updateAddressDetail(_ type: AddressSectionCellType, _ value: String) -> CreditCard {
        switch type {
        case .cityTown:
            self.address.cityTown = value
        case .state:
            self.address.state = value
        case .zipCode:
            self.address.zipCode = value
        case .addressOne:
            self.address.addressOne = value
        case .addressTwo:
            self.address.addressTwo = value
        }
        return self
    }
}
