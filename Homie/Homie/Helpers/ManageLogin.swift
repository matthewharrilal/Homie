//
//  ManageLogin.swift
//  Homie
//
//  Created by Matthew Harrilal on 1/27/18.
//  Copyright © 2018 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

struct LoginManager {
    
    func logUserIn(completionHandler: @escaping(Data) -> Void) {
        userNetworking(target: .fetchUsers, success: { (response) in
            let json = try? response.mapJSON()
            print(json)
        }, error: { (error) in
            print(error)
        }, failure: { (moyaError) in
            print(moyaError)
        })
        
    }
}
