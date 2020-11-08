//
//  CoursesViewController.swift
//  workWithNetwork
//
//  Created by Damir Lutfullin on 29.10.2020.
//

import UIKit

class CoursesViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var courses = [Course]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func fetchCoursesWithURLSession() {
        NetworkManager.getCourses { [weak self] (courses) in
            self?.courses = courses
            self?.tableView.reloadData()
        }
    }
    
    func fetchCoursesWithAlamofire() {
        AlamofireNetworkManager.getCourses(url: "https://swiftbook.ru//wp-content/uploads/api/api_courses")
    }
    
    private func configureCell(cell: TableViewCell, for indexPath: IndexPath) {
        
        let course = courses[indexPath.row]
        cell.courseNameLabel.text = course.name
        
        if let numberOfLessons = course.numberOfLessons {
            cell.numberOfLessons.text = "Number of lessons: \(numberOfLessons)"
        }
        
        if let numberOfTests = course.numberOfTests {
            cell.numberOfTests.text = "Number of tests: \(numberOfTests)"
        }
        
        //работа с данными ассинхронно в глобальном потоке
        DispatchQueue.global().async {
            guard
                let stringUrl = course.imageUrl,
                let imageUrl = URL(string: stringUrl),
                let imageData = try? Data(contentsOf: imageUrl)
            else { return }
            
            // радота с вью ассинхронно в главном потоке
            DispatchQueue.main.async {
                cell.courseImage.image = UIImage(data: imageData)
            }
        }
    }
    
}

extension CoursesViewController: UITableViewDelegate {
    
}

extension CoursesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        configureCell(cell: cell, for: indexPath)
        return cell
    }
}
