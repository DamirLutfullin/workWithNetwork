//
//  ImageProperties.swift
//  workWithNetwork
//
//  Created by Damir Lutfullin on 04.11.2020.
//

import UIKit

struct ImageProperties {
    let key: String
    let data: Data
    
    init?(image: UIImage, key: String) {
        guard let data = image.pngData() else { return nil }
        self.data = data
        self.key = key
    }
}
