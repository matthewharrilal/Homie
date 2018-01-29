//
//  SignUpViewController.swift
//  Homie
//
//  Created by Matthew Harrilal on 1/29/18.
//  Copyright © 2018 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTapped()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        EmailandPassword.email = emailTextField.text!
        EmailandPassword.password = passwordTextField.text!
        userNetworking(target: .createUsers, success: { (response) in
            let json = try? response.mapJSON()
        }, error: { (error) in
            print(error)
        }, failure: { (MoyaError) in
            print(MoyaError)
        }, controller: self)
    }
    
}
