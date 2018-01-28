//
//  UserModel.swift
//  Homie
//
//  Created by Matthew Harrilal on 1/27/18.
//  Copyright © 2018 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class User: Codable {
    var email: String
    var password: String
    var credential: String
    init(email: String, password: String) {
        self.email = email
        self.password = password
        self.credential = 
    }
}
