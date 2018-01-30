//
//  ProfileViewController.swift
//  Homie
//
//  Created by Matthew Harrilal on 1/30/18.
//  Copyright © 2018 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class ProfileViewController: UIViewController {
   
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userBioTextView: UITextView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUsername()
        
        
//        print(user)
//        print(user?.profilePicture)
//        let url = URL(string: "http://eswob.org/wp-content/uploads/2016/02/a4517f74-ff7f-4b47-871c-6999c9a7395f-e1455305420868.png")
//        print(url)
//        profileImageView.kf.setImage(with: url)
//        userBioTextView.text = user?.bio
        
        profileNetworking(target: .fetchProfiles, success: { (response) in
            let json = try? response.mapJSON()
            print(json)
        }, error: { (error) in
            print(error)
        }, failure: { (MoyaError) in
            print(MoyaError)
        }, controller: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUsername() {
        usernameLabel.text = EmailandPassword.email
    }

}


