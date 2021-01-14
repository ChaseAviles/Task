//
//  TaskDetailViewController.swift
//  Task
//
//  Created by Johnathan Aviles on 1/13/21.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    var task: Task?
    var date: Date?

    // MARK: - Outlets
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        
    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = taskNameTextField.text, !name.isEmpty else { return }
        if let task = task {
            TaskController.shared.update(task: task, name: name, notes: taskNotesTextView.text, dueDate: date)
        } else {
            TaskController.shared.createTaskWith(name: name, notes: taskNotesTextView.text, dueDate: date)
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        self.date = taskDueDatePicker.date
    }
    
    func updateViews(){
        guard let task = task else { return }
        taskNameTextField.text = task.name
        taskNotesTextView.text = task.notes
        taskDueDatePicker.date = task.dueDate ?? Date()
        
    }
    
    
}
