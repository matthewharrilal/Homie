//
//  QRViewController.swift
//  Homie
//
//  Created by Matthew Harrilal on 1/29/18.
//  Copyright © 2018 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class QRGeneratorViewController: UIViewController {
    
    @IBOutlet weak var qrImageView: UIImageView!
    @IBOutlet weak var qrLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        convertToQRCode()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func convertToQRCode() {
        guard let qrLabel = qrLabel.text else {return}
        let data = qrLabel.data(using: .ascii, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        
        let image = UIImage(ciImage: (filter?.outputImage)!)
        qrImageView.image = image
    }
}
