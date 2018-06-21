//
//  QueryService.swift
//  FinalProyect
//
//  Created by Alexis Gonzalez on 5/19/18.
//  Copyright © 2018 alexgsolutions. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

 private var places: [Places] = []

enum APIResource {
    
    static let baseURL = "https://data.pr.gov/resource/jbv2-n7ar.json"
    var url: String {
        return APIResource.baseURL
    }
    static let CrimeStatisticUrl = "https://data.pr.gov/resource/pzaz-tkx9.json?$query="
    static let WebAddress = "https://data.pr.gov/Desarrollo-e-Infraestructura/Cuarteles-y-Comandancias/rjqi-csd2"
}

class QueryService {
    typealias JSONDictionary = [String: Any]
    typealias SuccessResult = (Bool, String) -> ()
    let appData = AppData.shared
    var errorMessage = ""
    
}

extension QueryService {

    func getAllPlaces(completion: @escaping SuccessResult) {
        Alamofire.request(APIResource.baseURL).responseJSON { (response) in
            //debugPrint(response)
            let decode = JSONDecoder()
            let placesResponse =  try! decode.decode([Places].self, from: response.data!)
            self.appData.updatePlacesList(with: placesResponse)
            //print(places)
             completion(true,self.errorMessage)
        }
       
    }
    
    func getCrimeStatisticByPlace(_ placeCity: String, completion: @escaping SuccessResult) {
        let fixSearchCity = placeCity.folding(options: .diacriticInsensitive, locale: .current)
        let sqlQuery = NSURL(string: "https://data.pr.gov/resource/pzaz-tkx9.json?%24query=SELECT%20delitos_code%2C%20Count(*)%20as%20count%20where%20area_policiaca%20%3D%20%22\(fixSearchCity.fixToCamelCase)%22%20GROUP%20BY%20delitos_code%20ORDER%20BY%20count%20DESC")! as URL
        
        Alamofire.request(sqlQuery).responseJSON { (response) in
            debugPrint(response)
            let decode = JSONDecoder()
            let crimeStatisticResponse =  try! decode.decode([CrimeStatistic].self, from: response.data!)
            self.appData.updateCrimeStatisticList(with: crimeStatisticResponse)
            //print(crimeStatisticResponse)
            completion(true,self.errorMessage)
        }
        
    }
    
    private func convertData<T:Decodable>(to type: T.Type, _ data: Data)-> T? {
        let decoder = JSONDecoder()
        return try? decoder.decode(type, from: data)
    }
}
    


