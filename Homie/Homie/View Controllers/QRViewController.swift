//
//  QRViewController.swift
//  Homie
//
//  Created by Matthew Harrilal on 1/29/18.
//  Copyright © 2018 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import SwiftQRCode

class QRViewController: UIViewController {
    
    @IBOutlet weak var qrImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        qrImageView.image = QRCode
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
