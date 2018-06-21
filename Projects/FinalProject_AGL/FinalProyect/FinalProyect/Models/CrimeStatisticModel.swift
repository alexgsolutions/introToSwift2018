//
//  CrimeStatisticModel.swift
//  FinalProyect
//
//  Created by Alexis Gonzalez on 5/26/18.
//  Copyright © 2018 alexgsolutions. All rights reserved.
//

import Foundation

struct CrimeStatistic: Codable {
    let count: String?
    let delitosCode: String?
    
    enum CodingKeys: String, CodingKey {
        case count
        case delitosCode = "delitos_code"
    }
}
