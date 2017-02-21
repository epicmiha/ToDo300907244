//
//  ToDoCell.swift
//  ToDo300907244
//  300907244
//  Created by Mykhailo Obelchak on 2017-02-20.
//  Copyright © 2017 Mykhailo Obelchak. All rights reserved.
//
//  TableCell for todo

import UIKit
import FirebaseDatabase

class ToDoCell: UITableViewCell {

    var donePressedAction: ((UITableViewCell) -> Void)?
    
    @IBOutlet weak var toDoName: UILabel!
    @IBOutlet weak var doneSwitch: UISwitch!
    
    //setting up the cell
    //setting switch state and text (normal/faded and crossed)
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
    
    //update completion for todo
    func updateDone(todo: ToDo) {
        if todo.done {
            todo.done = false
        } else {
            todo.done = true
        }
        todo.ref?.updateChildValues(todo.toAnyObject() as! [AnyHashable : Any])
    }

}
