//
//  EmployeeTaskViewController.swift
//  SmallBiz
//
//  Created by Colby Mehmen on 5/3/23.
//

import UIKit

class EmployeeTaskViewController: UIViewController {
    var employee: Employee!

    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var addTaskTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewTitle()
        
        taskTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addTaskButtonTapped(_ sender: Any) {
        guard let taskTitle = addTaskTextField.text,
              let employee = employee,
              !taskTitle.isEmpty
        else {
            return
        }
        print("b4 >>\(employee.tasks.count)")
        
        TaskController.assignTaskTo(employee, taskTitle: taskTitle)
        print(">>\(employee.tasks.count)")
        addTaskTextField.text = nil
        addTaskTextField.resignFirstResponder() // nice
        taskTableView.reloadData()
    }
    
    func setupViewTitle() {
        navigationItem.title = "\(employee.firstName)'s Tasks"
    }
}

extension EmployeeTaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("returning a count of employee!.tasks.count")
        return employee!.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = employee.tasks[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SmallBizUitl.taskCellIndentifier, for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
        cell.taskLabel.text = task.title
        cell.task = task
        cell.delegate = self
        //cell.statusButton.= (task.isCompleted) ? UIImage(systemName: "circle.fill") : UIImage(systemName: "circle")
        return cell
        
    }
}

extension EmployeeTaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = employee.tasks[indexPath.row]
            TaskController.deleteTaskFrom(employee, task)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension EmployeeTaskViewController: TaskTableViewCellDelegate {
    func taskTableViewCell(task: Task) {
        TaskController.changeTaskStatus(employee, task: task)
        taskTableView.reloadData()
    }
}


