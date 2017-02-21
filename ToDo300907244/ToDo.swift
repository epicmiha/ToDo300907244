//
//  ToDo.swift
//  ToDo300907244
//  300907244
//  Created by Mykhailo Obelchak on 2017-02-20.
//  Copyright © 2017 Mykhailo Obelchak. All rights reserved.
//
//  Model of ToDo task

import Foundation
import FirebaseDatabase

class ToDo {
    private var _name: String!
    private var _details: String?
    private var _done: Bool!
    private var _ref: FIRDatabaseReference?
    
    var name: String{
        get {
            return _name
        }
        set {
            _name = newValue
        }
    }
    
    var details: String? {
        get {
            return _details
        }
        set {
            _details = newValue
        }
    }
    
    var done: Bool {
        get {
            return _done
        }
        set {
            _done = newValue
        }
    }
    
    var ref: FIRDatabaseReference? {
        get {
            return _ref
        }
        set {
            _ref = newValue
        }
    }
    
    init(name: String) {
        self._name = name
        self._done = false
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self._name = snapshotValue["name"] as! String
        self._details = (snapshotValue["details"] as! String)
        self._done = snapshotValue["done"] as! Bool
        _ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "details": details ?? "",
            "done": done
        ]
    }

    
}
