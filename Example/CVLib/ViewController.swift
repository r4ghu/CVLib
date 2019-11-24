//
//  ViewController.swift
//  CVLib
//
//  Created by r4ghu on 11/23/2019.
//  Copyright (c) 2019 r4ghu. All rights reserved.
//

import UIKit

// Don't forget to import the pod
import CVLib

class ViewController: UIViewController {

    // Declare or connect an image view. Be sure to set the width/height constraints to the same value
    @IBOutlet weak var testImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Step 3: Call the roundViewWidth method on your imageView
        testImageView.roundViewWith(borderColor: UIColor.white, borderWidth: 5.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

