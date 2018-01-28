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
    var email: String?
    var password: String?
    var credential: String?
    init(email: String?, password: String?) {
        self.email = email
        self.password = password
        self.credential = BasicAuth.generateBasicAuthHeader(email: email!, password: password!)
    }
    
    enum TopLevelKeys: String, CodingKey {
        case email
        case password
    }
    
    required convenience init(from decoder: Decoder) {
        let container = try? decoder.container(keyedBy: TopLevelKeys.self)
        let email = try? container?.decodeIfPresent(String.self, forKey: .email)
        let password = try? container?.decodeIfPresent(String.self, forKey: .password)
        self.init(email: email!, password: password!)
    }
}
