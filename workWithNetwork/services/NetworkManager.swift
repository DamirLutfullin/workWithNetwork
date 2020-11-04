//
//  NetworkManager.swift
//  workWithNetwork
//
//  Created by Damir Lutfullin on 04.11.2020.
//

import UIKit

class NetworkManager {
    
   static func getRequest() {
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
    
   static func postRequest() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        let dict = ["course" : "Networking", "lessons" : "30"]
        var request = URLRequest(url: url)
        guard let httpBody = try? JSONSerialization.data(withJSONObject: dict, options: []) else { return }
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        let session = URLSession.shared
        session.uploadTask(with: request, from: httpBody) { (data, response, error) in
            if let data = data {
                let json = try! JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            }
        }.resume()
    }
    
    static func downloadImage(completion: @escaping (Data) ->()) {
        guard let url = URL(string:"https://upload.wikimedia.org/wikipedia/commons/4/42/Blue_sky%2C_white-gray_clouds.JPG") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return}
            DispatchQueue.main.async {
                completion(data)
            }
        }.resume()
    }
    
    static func getCourses(completion: @escaping ([Course]) -> ()) {
        //        let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_course"
        let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
        //        let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_website_description"
        //        let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_missing_or_wrong_fields"
        
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let courses = try decoder.decode([Course].self, from: data)
                DispatchQueue.main.async {
                    completion(courses)
                }
            } catch let error {
                print(error, error.localizedDescription)
            }
        }.resume()
    }
    
    static func uploadImage(url: String) {
        guard
            let image = UIImage(named: "1"),
            let imageProperties = ImageProperties(image: image, key: "image"),
            let url = URL(string: url)
        else { return }
        
        let httpHeaders = ["Authorization" : "Client-ID 3c6530e32aa4243"]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = httpHeaders
        request.httpBody = imageProperties.data
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch let error {
                    print(error)
                }
            }
        }.resume()
    }
}
