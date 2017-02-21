//
//  DetailsViewController.swift
//  ToDo300907244
//
//  Created by Serhii Pianykh on 2017-02-20.
//  Copyright © 2017 Mykhailo Obelchak. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    private var _todo : ToDo!
    
    
    @IBOutlet weak var toDoName: UITextField!
    @IBOutlet weak var toDoDetails: UITextField!
    @IBOutlet weak var doneSwitch: UISwitch!
    
    var todo: ToDo {
        get {
            return _todo
        }
        
        set {
            _todo = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        toDoName.text = todo.name
        toDoDetails.text = todo.details
        if todo.done {
            doneSwitch.isOn = true
        } else {
            doneSwitch.isOn = false
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func savePressed(_ sender: Any) {
        todo.name = toDoName.text!
        todo.details = toDoDetails.text!
        todo.done = doneSwitch.isOn
        todo.ref?.updateChildValues(todo.toAnyObject() as! [AnyHashable : Any])
        _ = navigationController?.popViewController(animated: true)
    }

}
