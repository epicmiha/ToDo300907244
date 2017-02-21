//
//  ListViewController.swift
//  ToDo300907244
//
//  Created by Serhii Pianykh on 2017-02-20.
//  Copyright © 2017 Mykhailo Obelchak. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var todoRef: FIRDatabaseReference? = nil
    
    let storage = FIRDatabase.database().reference(withPath: "todos")

    
    var list = [ToDo]()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
        todoRef = storage.child((FIRAuth.auth()?.currentUser?.uid)!)
        
        todoRef?.observe(.value, with: { snapshot in
            var todos = [ToDo]()
            for item in snapshot.children {
                let task = ToDo(snapshot: item as! FIRDataSnapshot)
                todos.append(task)
            }
            self.list = todos
            self.tableView.reloadData()
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    @IBAction func logoutPressed(_ sender: Any) {
        try! FIRAuth.auth()!.signOut()
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as? ToDoCell {
            let todo = list[indexPath.row]
            
            cell.donePressedAction = { (self) in
                cell.updateDone(todo: todo)
            }
            cell.setCell(todo: todo)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let todo = list[indexPath.row]
            todo.ref?.removeValue()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = list[indexPath.row]
        performSegue(withIdentifier: "DetailsVC", sender: todo)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController {
            if let todo = sender as? ToDo {
                destination.todo = todo
            }
            
        }
    }
    
    
    @IBAction func addToDoPressed(_ sender: Any) {
        let alert = UIAlertController(title: "ToDo",
                                      message: "Add a task",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { _ in
                                        // 1
                                        guard let textField = alert.textFields?.first,
                                            let text = textField.text else { return }
                                        
                                        // 2
                                        let todo = ToDo(name: text)
                                        // 3
                                        let todoRef = self.todoRef!.childByAutoId()
                                        
                                        // 4
                                        todoRef.setValue(todo.toAnyObject())
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}
