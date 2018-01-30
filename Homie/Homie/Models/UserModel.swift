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
    var bio: String?
    var profilePicture: String?
    init(email: String?, password: String?, bio: String?=nil, profilePicture: String?=nil) {
        self.email = email
        self.password = password
        self.bio = bio
        self.profilePicture = profilePicture
        self.credential = BasicAuth.generateBasicAuthHeader(email: email!, password: password!)
    }
    
    enum TopLevelKeys: String, CodingKey {
        case email
        case password
        case profilePicture = "profile_picture"
        case bio
    }
    
    required convenience init(from decoder: Decoder) {
        let container = try? decoder.container(keyedBy: TopLevelKeys.self)
        let email = try? container?.decodeIfPresent(String.self, forKey: .email)
        let password = try? container?.decodeIfPresent(String.self, forKey: .password)
        let profilePicture = try? container?.decodeIfPresent(String.self, forKey: .profilePicture)
        let bio = try? container?.decodeIfPresent(String.self, forKey: .bio)
        self.init(email: email!, password: password!, bio: bio!, profilePicture: profilePicture!)
    }
}
