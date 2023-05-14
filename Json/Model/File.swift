//
//  File.swift
//  Json
//
//  Created by Anton Akhmedzyanov on 14.05.2023.
//

import Foundation

struct Course: Decodable {
    let name: String
    let imageUrl: URL
    let number_of_lessons: Int
    let number_of_tests: Int
}

struct Website: Decodable {
    let courses: [Course]
    let websiteDescription: String
    let websiteName: String
}
