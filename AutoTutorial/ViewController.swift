//
//  ViewController.swift
//  AutoTutorial
//
//  Created by Tula Ram Subba on 5/3/17.
//  Copyright © 2017 Tula Ram Subba. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var signInSelector: UISegmentedControl!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    var isSignIn:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        if FIRAuth.auth()?.currentUser != nil {
            self.performSegue(withIdentifier: "goToHome", sender: self)

        }
    }

    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
        isSignIn = !isSignIn
        
        if isSignIn {
            signInLabel.text = "Sign In"
            signInButton.setTitle("Sign In", for: .normal)
        }
        else {
            signInLabel.text = "Register"
            signInButton.setTitle("Register", for: .normal)
        }
    }
   
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            if isSignIn {
                FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                    if let u = user {
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                        
                    }
                    else {
                        //Error: check error and show message
                    }
                })
            }
            else {
                FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                    if let u = user {
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                        
                    }
                })
            }
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
 
}

