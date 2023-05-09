//
//  DefaultTaskController.swift
//  SmallBiz
//
//  Created by Colby Mehmen on 5/8/23.
//

import Foundation

class DefaultTaskController {
    
    static var shared = DefaultTaskController()
    
    static var defaultTaskItems: [Task] = {
        let def = [
            "Payroll",
            "Onboarding",
            "Employee Profile",
            "Work shoes",
        ]
        return def.compactMap({ return Task(title: $0)})
    }()
    
    var tasks: [Task] = []
    
    init() {
        load()
    }
    
    func addDefaultTask(task: Task) {
        tasks.append(task)
    }
    
    func removeDefaultTask(task: Task) {
        guard let index = tasks.firstIndex(where: { $0 == task}) else {
            return
        }
        tasks.remove(at: index)
    }
    
    func load() {
        do {
            guard let url = FileManagerUtil.shared.getUrl(for: .defaultTask) else {
                self.tasks = DefaultTaskController.defaultTaskItems
                return
            }
            
            let data = try Data(contentsOf: url)
            let jsonDecoder = JSONDecoder()
            let decodedData = try jsonDecoder.decode([Task].self, from: data)
            self.tasks = decodedData
            
        } catch {
            self.tasks = DefaultTaskController.defaultTaskItems
            print(error.localizedDescription)
        }
    }
    
    func cache() {
        do {
            guard let url = FileManagerUtil.shared.getUrl(for: .defaultTask) else {
                return
            }
            let jsonEncoder = JSONEncoder()
            let encodedData = try jsonEncoder.encode(tasks)
            try encodedData.write(to: url)
        } catch {
            print(error.localizedDescription)
        }
    }
}

