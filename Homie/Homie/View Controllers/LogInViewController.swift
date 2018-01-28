//
//  ViewController.swift
//  Homie
//
//  Created by Matthew Harrilal on 1/27/18.
//  Copyright © 2018 Matthew Harrilal. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logInButton(_ sender: Any) {
        guard let email = emailTextField.text,
        let password = passwordTextField.text else {return}
        EmailandPassword.email = email
        EmailandPassword.password = password
        let logIn = LoginManager()
        logIn.logUserIn { (data) in
            print(data)
        }
        self.performSegue(withIdentifier: "toHome", sender: self)
    }
    
}

