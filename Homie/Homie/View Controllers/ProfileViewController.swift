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
    var user: User?

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userBioTextView: UITextView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUsername()
        

        
        userNetworking(target: .fetchUsers, success: { (response) in
            guard let profilePicture = try? response.mapString(atKeyPath: "profile_picture") else {return}
            guard let bio = try? response.mapString(atKeyPath: "bio") else {return}
            let url = URL(string: profilePicture)
            self.profileImageView.kf.setImage(with: url)
            self.userBioTextView.text = bio
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


