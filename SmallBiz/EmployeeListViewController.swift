//
//  ViewController.swift
//  SmallBiz
//
//  Created by Colton Swapp on 8/26/22.
//

import UIKit

extension Array<String> {
    public subscript(safeIndex safe: Int) -> String {
        guard safe >= 0, safe < endIndex else {
            return ""
        }
        return self[safe]
    }
}

class EmployeeListViewController: UIViewController {
    
    @IBOutlet weak var employeeNameTextField: UITextField!
    @IBOutlet weak var employeeListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        
    }
    
    func setUpTableView() {
        employeeListTableView.dataSource = self
        employeeListTableView.delegate = self
    }

    @IBAction func addNewEmployeeButtonTapped(_ sender: Any) {
        guard let newEmployeeName = employeeNameTextField.text,
              !newEmployeeName.isEmpty else {
            return
        }
        
        let nameArray = newEmployeeName.components(separatedBy: " ")
        
        let newEmployee = Employee(firstName: nameArray[safeIndex: 0], lastName: nameArray[safeIndex: 1])
        EmployeeController.shared.addEmployee(employee: newEmployee)
        
        employeeNameTextField.text = nil
        
        employeeListTableView.reloadData()
        // logic to add new employee
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueUtil.toEmployeeTask {
            let destinaiton = segue.destination as? EmployeeTaskViewController
            guard let selectedEmployeeIndex = employeeListTableView.indexPathForSelectedRow?.row else {
                return
            }
            destinaiton?.employee = EmployeeController.shared.employees[selectedEmployeeIndex]
            
            
        }
    }
    
}

extension EmployeeListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EmployeeController.shared.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let employee = EmployeeController.shared.employees[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SmallBizUitl.employeeCellIndentifier, for: indexPath)
        var contentConfig = cell.defaultContentConfiguration()
        contentConfig.text = "\(employee.firstName) \(employee.lastName)"
        cell.contentConfiguration = contentConfig
        return cell
    }
}

extension EmployeeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let selectedEmployee = EmployeeController.shared.employees[indexPath.row]
            EmployeeController.shared.deleteEmployee(employee: selectedEmployee)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
            guard let self = self else { return }
            self.employeeListTableView.deselectRow(at: indexPath, animated: false)
        }
    }
}
