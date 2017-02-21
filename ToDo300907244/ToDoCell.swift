//
//  ToDoCell.swift
//  ToDo300907244
//
//  Created by Serhii Pianykh on 2017-02-20.
//  Copyright © 2017 Mykhailo Obelchak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ToDoCell: UITableViewCell {

    var donePressedAction: ((UITableViewCell) -> Void)?
    
    @IBOutlet weak var toDoName: UILabel!
    @IBOutlet weak var doneSwitch: UISwitch!
    
    func setCell(todo: ToDo) {
        toDoName.text = todo.name
        if (todo.done) {
            doneSwitch.isOn = true
            let attributedString = NSMutableAttributedString(string: toDoName.text!)
            attributedString.addAttribute(NSStrikethroughStyleAttributeName, value: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue), range: NSMakeRange(0, attributedString.length))
            toDoName.attributedText=attributedString
            toDoName.textColor = UIColor.lightGray
        } else {
            doneSwitch.isOn = false
            toDoName.textColor = UIColor.black
        }

    }
    
    @IBAction func doneSwitched(_ sender: UISwitch) {
        donePressedAction!(self)
    }
    
    func updateDone(todo: ToDo) {
        if todo.done {
            todo.done = false
        } else {
            todo.done = true
        }
        todo.ref?.updateChildValues(todo.toAnyObject() as! [AnyHashable : Any])
    }

}
