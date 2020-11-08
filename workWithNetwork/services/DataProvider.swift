//
//  DataProvider.swift
//  workWithNetwork
//
//  Created by Damir Lutfullin on 04.11.2020.
//

import UIKit

class DataProvider: NSObject {
    
    private var downloadTask: URLSessionDownloadTask!
    
    private lazy var bgSession: URLSession = {
        let config = URLSessionConfiguration.background(withIdentifier: "com.damirLutfullin.workWithNetwork")
        config.isDiscretionary = true
        config.sessionSendsLaunchEvents =  true
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()
    
}

extension DataProvider: URLSessionDelegate {
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        
    }
}
