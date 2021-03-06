//
//  ProfileNetworkingLayer.swift
//  Homie
//
//  Created by Matthew Harrilal on 1/30/18.
//  Copyright © 2018 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import Moya

enum DifferentProfiles {
    case fetchProfiles
    case createProfiles
    case updateProfiles
    // Later on for refactoring what we can essentially do is that we can optimize where we scale this file in the user class some of this code might end up being redundant
}

let profile = ProfileViewController()


extension DifferentProfiles: TargetType {
    var baseURL: URL {
        let baseUrl = URL(string: "https://homie-application.herokuapp.com/")
        return baseUrl!
    }
    
    var path: String {
        switch self {
            case .fetchProfiles:fallthrough
            case .createProfiles:fallthrough
            case .updateProfiles:
            return "profile"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createProfiles:
            return .post
        case .fetchProfiles:
            return .get
        case .updateProfiles:
            return .patch
        }
    }
    
    var sampleData: Data {
        switch self {
        case .fetchProfiles, .createProfiles, .updateProfiles:
            return Data()

        }
    }
    
    var task: Task {
        switch self {
        case .fetchProfiles:
            return .requestPlain
        case .updateProfiles, .createProfiles:
            return .requestParameters(parameters: ["profile_picture": "Temporary Profile", "bio": profile.userBioTextView.text], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        let user = User(email: EmailandPassword.email, password: EmailandPassword.password)
        switch self {
        case .createProfiles, .fetchProfiles, .updateProfiles:
            return ["Authorization": (user.credential)!]
        }
    }
    
}


func profileNetworking(target: DifferentProfiles, success successCallBack: @escaping(Response) -> Void, error errorCallBack: @escaping(Swift.Error) -> Void, failure failureCallBack: @escaping(MoyaError) -> Void, controller: UIViewController) {
    let provider = MoyaProvider<DifferentProfiles>()
    provider.request(target) { (result) in
        switch result {
        case .success(let response):
            if response.statusCode >= 200 && response.statusCode <= 300 {
                print(response.statusCode)
                successCallBack(response)
            }
            else {
                print(response.statusCode)
                loadingProfileError(controller: controller)
            }
        case .failure(let error):
            loadingProfileError(controller: controller)
            
        }
    }
}
