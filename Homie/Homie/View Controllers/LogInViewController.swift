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
        emailTextField.layer.borderWidth = 1 / UIScreen.main.nativeScale
        var contentEdgeInserts = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        emailTextField.layer.cornerRadius = emailTextField.frame.height / 2
        emailTextField.layer.masksToBounds = true
//        emailTextField.frame.size.height = 40
//        emailTextField.frame.size.height = 40
        
        
        passwordTextField.layer.borderWidth = 1 / UIScreen.main.nativeScale
//        var x = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        passwordTextField.layer.cornerRadius = emailTextField.frame.height / 2
        passwordTextField.layer.masksToBounds = true
        self.navigationController?.navigationBar.isHidden = true
        self.hideKeyboardWhenTapped()
        self.navigationController?.navigationBar.isHidden = true
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
        userNetworking(target: .fetchUsers, success: { (response) in
            let json = try? response.mapJSON()
            print(json)
            self.performSegue(withIdentifier: "toHome", sender: self)
        }, error: { (error) in
            print(error)
        }, failure: { (MoyaError) in
            print(MoyaError)
        }, controller: self)
    }
    
}
