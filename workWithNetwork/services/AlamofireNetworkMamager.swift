//
//  AlamofireNetworkMamager.swift
//  workWithNetwork
//
//  Created by Damir Lutfullin on 08.11.2020.
//

import Foundation
import Alamofire

class AlamofireNetworkManager {
    
    static func getCourses(url: String) {
        AF.request(url, method: .get).responseJSON { (response) in
            print(response)
        }
        
        
    }
 
    
}
