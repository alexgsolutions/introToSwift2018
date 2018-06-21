//
//  PlacesModel.swift
//  FinalProyect
//
//  Created by Alexis Gonzalez on 5/18/18.
//  Copyright © 2018 alexgsolutions. All rights reserved.
//

import Foundation

struct Places: Codable {
    var direcci_n_f_sica: String? = ""
    var edificios: String? = ""
    var latitud: String? = ""
    var location: Location?
    var longitud: String? = ""
    var municipio: String? = ""
    var n_m_aep: String? = ""
    var regi_n: String? = ""
}
