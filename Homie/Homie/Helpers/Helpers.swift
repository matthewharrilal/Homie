//
//  Helpers.swift
//  Homie
//
//  Created by Matthew Harrilal on 1/29/18.
//  Copyright © 2018 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit


extension  UIViewController {
    func hideKeyboardWhenTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

func logInAlert(controller: UIViewController) {
    let alert = UIAlertController(title: "Invalid Email Or Password", message: "Please Try Logging In With Different Credentials", preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "Try Again", style: .cancel, handler: nil)
    alert.addAction(cancelAction)
    controller.present(alert, animated: true, completion: nil)
}

func missingInput(controller: UIViewController) {
    let alert = UIAlertController(title: "Please enter valid input", message: "One or more of the credentials have not been filled in", preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "Try Aagain", style: .cancel, handler: nil)
    alert.addAction(cancelAction)
    controller.present(alert, animated: true, completion: nil)
}
