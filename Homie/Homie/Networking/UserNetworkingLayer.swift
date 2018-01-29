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
        let baseUrl = URL(string: "https://homie-application.herokuapp.com/")
        return baseUrl!
    }
    
    var path: String {
        switch self {
        case .fetchUsers: fallthrough
        case .createUsers:
            return "users"
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
        case .fetchUsers:
            return ["Authorization": (user.credential)!]
        case .createUsers:
            return [:]
        }
    }
    
}

func userNetworking(target: DifferentUsers, success successCallBack: @escaping(Response)-> Void, error errorCallBack: @escaping(Swift.Error) -> Void, failure failureCallBack: @escaping(MoyaError) -> Void, controller: UIViewController) {
    let provider = MoyaProvider<DifferentUsers>()
    provider.request(target) { (result) in
        switch result {
        case .success(let response):
            if response.statusCode >= 200 && response.statusCode <= 300 {
                print(response.statusCode)
//                let logInVC = LogInViewController()
//                logInVC.performSegue(withIdentifier: "toHome", sender: nil)
                successCallBack(response)
            }
            else {
                logInAlert(controller: controller)
            }
        case .failure(let error):
            fatalError("Login Credentials Were Not Right")
        }
    }
}
