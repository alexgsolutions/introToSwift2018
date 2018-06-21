//
//  StringExtention.swift
//  FinalProyect
//
//  Created by Alexis Gonzalez on 5/26/18.
//  Copyright © 2018 alexgsolutions. All rights reserved.
//

import Foundation

extension String {
    var fixToCamelCase: String {
        let first = self.prefix(1).capitalized
        let other = self.dropFirst()
        let other2 = other.lowercased()
        return first + other2
    }
}
