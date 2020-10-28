//
//  firstViewController.swift
//  workWithNetwork
//
//  Created by Damir Lutfullin on 28.10.2020.
//

import UIKit
struct Answer {
    var id : Int
    var userId : Int
    var title: String
    var body : String
}

class FirstViewController: UIViewController {
    
    
    @IBAction func getRequest(_ sender: UIButton) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            do {
                let anyJSON = try JSONSerialization.jsonObject(with: data, options: [])
                let convertingToJSON = anyJSON as? [String : Any]
                let anser = Answer(id: convertingToJSON?["id"] as! Int,
                                   userId: convertingToJSON?["userId"] as! Int,
                                   title: convertingToJSON?["title"] as! String,
                                   body: convertingToJSON?["body"] as! String)
                print("""
                    id: \(anser.id)
                    userId: \(anser.userId)
                    title: \(anser.title)
                    body: \(anser.body.replacingOccurrences(of: "\n", with: " "))
                    """)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    @IBAction func postRequest(_ sender: UIButton) {
        
        
    }
}
