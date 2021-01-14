//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Johnathan Aviles on 1/13/21.
//

import UIKit

class TaskListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.shared.loadFromPersistenceStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TaskController.shared.tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
        
        let task = TaskController.shared.tasks[indexPath.row]
        cell.textLabel?.text = task.name
        
        cell.delegate = self
        cell.task = task

        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let taskToDelete = TaskController.shared.tasks[indexPath.row]
            TaskController.shared.delete(task: taskToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTaskDetail"{
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? TaskDetailViewController else { return }
            let taskToSend = TaskController.shared.tasks[indexPath.row]
            destination.task = taskToSend
        }
    }
}

extension TaskListTableViewController: TaskCompletionDelegate {
    func taskCellButtonTapped(_ sender: TaskTableViewCell) {
        guard let task = sender.task else { return }
        TaskController.shared.toggleIsComplete(task: task)
        sender.updateViews()
    }
}
