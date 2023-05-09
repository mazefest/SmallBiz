//
//  Task.swift
//  SmallBiz
//
//  Created by Colby Mehmen on 5/3/23.
//

import Foundation

class Task: Codable {
    var title: String
    var isCompleted: Bool
    var id: String
    
    init(title: String, isCompleted: Bool = false, id: String = UUID().uuidString) {
        self.title = title
        self.isCompleted = isCompleted
        self.id = id
    }
}

extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
}
