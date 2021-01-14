//
//  TaskController.swift
//  Task
//
//  Created by Johnathan Aviles on 1/13/21.
//

import Foundation

class TaskController {
    
    static let shared = TaskController()
    
    var tasks: [Task] = []
    
    // MARK: - CRUD
    func createTaskWith(name: String, notes: String?, dueDate: Date?) {
        let newTask = Task(name: name, notes: notes, dueDate: dueDate)
        tasks.append(newTask)
        saveToPersistenceStore()
    }
    
    func update(task: Task, name: String, notes: String?, dueDate: Date?){
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        saveToPersistenceStore()
    }
    
    func toggleIsComplete(task: Task) {
        task.isComplete.toggle()
        saveToPersistenceStore()
    }
    
    func delete(task: Task) {
        guard let index = tasks.firstIndex(of: task) else { return }
        tasks.remove(at: index)
        saveToPersistenceStore()
    }
    
    // MARK: - Persistence
    
    // fileURL function to save and load from
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Task.json")
        return fileURL
    }
    
    //save
    func saveToPersistenceStore(){
        do {
            let data = try JSONEncoder().encode(tasks)
            try data.write(to: fileURL())
        } catch{
            print(error.localizedDescription)
        }
        
    }
    //load
    func loadFromPersistenceStore(){
        do{
            let data = try Data(contentsOf: fileURL())
            tasks = try JSONDecoder().decode([Task].self, from: data)
        } catch{
            print(error)
            print(error.localizedDescription)
        }
    }
}
