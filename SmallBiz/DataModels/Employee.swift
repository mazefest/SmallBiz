//
//  Employee.swift
//  SmallBiz
//
//  Created by Colby Mehmen on 4/25/23.
//

import Foundation

class Employee: Codable {
    var firstName: String
    var lastName: String
    var skillLevel: String
    var id: String
    var tasks: [Task]
    
    init(firstName: String, lastName: String, skillLevel: String = "N/A", id: String = UUID().uuidString, tasks: [Task] = []) {
        self.firstName = firstName
        self.lastName = lastName
        self.skillLevel = skillLevel
        self.id = id
        self.tasks = tasks
    }
}

