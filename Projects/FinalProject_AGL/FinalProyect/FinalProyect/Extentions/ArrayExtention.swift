//
//  ArrayExtention.swift
//  FinalProyect
//
//  Created by Alexis Gonzalez on 5/28/18.
//  Copyright © 2018 alexgsolutions. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    mutating func removeObject(_ obj: Element) {
        self = self.filter { $0 != obj }
    }
}
