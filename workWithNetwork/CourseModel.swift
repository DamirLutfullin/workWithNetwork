//
//  CourseModel.swift
//  workWithNetwork
//
//  Created by Damir Lutfullin on 29.10.2020.
//

import Foundation

struct Course: Codable {
    let id: Int
    let name: String
    let link: String
    let imageUrl: String
    let number_of_lessons: Int
    let number_of_tests: Int
}
