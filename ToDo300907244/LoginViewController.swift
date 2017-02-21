//
//  ViewController.swift
//  ToDo300907244
//
//  Created by Serhii Pianykh on 2017-02-20.
//  Copyright © 2017 Mykhailo Obelchak. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signBtn: UIButton!
    
    var loginSuccess: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signBtn.layer.cornerRadius = 4
    }

    @IBAction func signPressed(_ sender: UIButton) {
        FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passwordField.text!, completion: { (user, error) in
            if error != nil {
                //if user exists - login
                self.login()
            } else {
                //user created and now login
                print("User created")
                self.login()
            }
        })
    }
    
    func login() {
        FIRAuth.auth()?.signIn(withEmail: emailField.text!, password: passwordField.text!, completion:  { (user, error) in
            if error != nil {
                //if error occured while signing in
                print("Incorrect")
                //create alert controller
                let alert = UIAlertController(title: "Error",message: nil, preferredStyle: UIAlertControllerStyle.alert)
                //create message(action) for alert controller
                let message = UIAlertAction(title: "Invalid credentials", style: UIAlertActionStyle.default) { (action: UIAlertAction) -> Void in
                    //actions to be made when message clicked
                    self.emailField.text = ""
                    self.passwordField.text = ""
                }
                //adding action to alert
                alert.addAction(message)
                //presenting alert. UIAlerControllerStyle.Alert shows alert modally in the center of the screen
                self.present(alert, animated: true, completion: nil)
                
                
            } else {
                //if successfully signed in
                print("Success")
                //setting flag to true
                self.loginSuccess = true
                //performing segue with ShowMap identifier
                self.performSegue(withIdentifier: "ListVC", sender: self)
            }
        })
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "ListVC" {
            if loginSuccess != true {
                return false
            }
        }
        //otherwise - good to go
        return true
    }
    

}

