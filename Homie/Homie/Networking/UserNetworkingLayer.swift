//
//  UserNetworkingLayer.swift
//  Homie
//
//  Created by Matthew Harrilal on 1/27/18.
//  Copyright © 2018 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import Moya

struct EmailandPassword {
    static var email = ""
    static var password = ""
}

enum DifferentUsers {
    case fetchUsers
    case createUsers
}

extension DifferentUsers: TargetType {
    var baseURL: URL {
        let baseUrl = URL(string: "http://127.0.0.1:5000")
        return baseUrl!
    }
    
    var path: String {
        switch self {
        case .fetchUsers: fallthrough
        case .createUsers:
            return "/users"
        }
    }
    var method: Moya.Method {
        switch self {
        case .createUsers:
            return .post
        case .fetchUsers:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .fetchUsers:
            return Data()
        case .createUsers:
            var jsonBody = Data()
            let user:User? = nil
            
            do {
                jsonBody = try! JSONEncoder().encode(user)
            }
            catch {
                fatalError("Unresolved error \(error)")
            }
            return jsonBody
        }
    }
    
    var task: Task {
        switch self {
        case .createUsers, .fetchUsers:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let user = User(email: EmailandPassword.email, password: EmailandPassword.password)
        switch self {
        case .createUsers, .fetchUsers:
            return ["Authorization": (user.credential)!]
        }
    }
    
    
}
