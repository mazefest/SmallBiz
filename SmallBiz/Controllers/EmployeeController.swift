//
//  EmployeeController.swift
//  SmallBiz
//
//  Created by Colby Mehmen on 4/25/23.
//

import Foundation

class EmployeeController {
    static let shared = EmployeeController()
    
    var employees: [Employee] = []
        
    init() {
        load()
    }
    
    func addEmployee(employee: Employee) {
        // Declare a new employee object
        let newEmployee = employee

        // NEW
        if UserDefaults.standard.bool(forKey: "New Employee default items") {
            let tasks = DefaultTaskController.shared.tasks
            newEmployee.tasks = tasks
        }

        // Add that employee to our source of truth
        employees.append(newEmployee)
        print("Successfully added a \(newEmployee.firstName) to our list of employees.")

        // Save
        cache()
    }
    
    func getEmployee(id: String) -> Employee? {
        return employees.first(where: {$0.id == id})
    }
    
    func updateEmployee(updatedEmployee: Employee) {
        guard let index = employees.firstIndex(where: { $0.id == updatedEmployee.id }) else { return }
        employees[index] = updatedEmployee
        cache()
    }
    
    func deleteEmployee(employee: Employee) {
        guard let index = employees.firstIndex(where: { $0.id == employee.id }) else { return }
        employees.remove(at: index)
        cache()
    }
    
    func cache() {
        do {
            guard let url = FileManagerUtil.shared.getUrl(for: .employees) else {
                return
            }
            let jsonEncoder = JSONEncoder()
            let encodedData = try jsonEncoder.encode(employees)
            try encodedData.write(to: url)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func load() {
        do {
            guard let url = FileManagerUtil.shared.getUrl(for: .employees) else {
                return
            }
            
            let data = try Data(contentsOf: url)
            let jsonDecoder = JSONDecoder()
            let decodedData = try jsonDecoder.decode([Employee].self, from: data)
            self.employees = decodedData
            
        } catch {
            print(error.localizedDescription)
        }
    }
}

