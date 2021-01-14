//
//  TaskTableViewCell.swift
//  Task
//
//  Created by Johnathan Aviles on 1/13/21.
//

import UIKit

protocol TaskCompletionDelegate: AnyObject {
    func taskCellButtonTapped(_ sender: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: TaskCompletionDelegate?

    // MARK: - Actions
    @IBAction func completionButtonTapped(_ sender: Any) {
        if let delegate = delegate {
            delegate.taskCellButtonTapped(self)
    }
}
    
    func updateViews() {
        guard let task = task else { return }
        taskNameLabel.text = task.name
        if task.isComplete {
            completionButton.setBackgroundImage(UIImage(named: "complete"), for: .normal)
        } else {
            completionButton.setBackgroundImage(UIImage(named: "incomplete"), for: .normal)
        }
    }
    
}


