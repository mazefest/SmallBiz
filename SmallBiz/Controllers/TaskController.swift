//
//  TaskController.swift
//  SmallBiz
//
//  Created by Colby Mehmen on 5/3/23.
//

import Foundation

class TaskController {
    init() {
        
    }
    
    static func assignTaskTo(_ employee: Employee, taskTitle: String) {
        let newTask = Task(title: taskTitle)
        
        employee.tasks.append(newTask)
        
        EmployeeController.shared.cache()
        
    }
    
    static func deleteTaskFrom(_ employee: Employee, _ task: Task) {
            // Locate the index of the task we are attempting to remove
            guard let index = employee.tasks.firstIndex(of: task) else { return }

            // Remove task from employee
            employee.tasks.remove(at: index)
            print("Successfully removed task from \(employee.firstName)'s list of tasks.")

            // Use the Employee Controller to save changes
            EmployeeController.shared.cache()
    }
    
    static func changeTaskStatus(_ employee: Employee, task: Task) {
        guard let index = employee.tasks.firstIndex(of: task) else { return }
        employee.tasks[index].isCompleted.toggle()
            EmployeeController.shared.cache()
    }
}
