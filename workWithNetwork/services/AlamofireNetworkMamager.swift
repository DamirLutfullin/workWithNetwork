//
//  AlamofireNetworkMamager.swift
//  workWithNetwork
//
//  Created by Damir Lutfullin on 08.11.2020.
//

import Foundation
import Alamofire

class AlamofireNetworkManager {
    
    static func getCourses(url: String, completion: @escaping ([Course]) -> ()) {
        AF.request(url, method: .get).validate().response { (response) in
            
            switch response.result {
            case .success(let data):
                guard
                    let data = data,
                    let courses = try? JSONDecoder().decode([Course].self, from: data)
                else { return }
                DispatchQueue.main.async {
                    completion(courses)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
