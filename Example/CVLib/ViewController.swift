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
    //@IBOutlet weak var testImageView: UIImageView!
    @IBOutlet var cameraView: CameraView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    // Start session
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // MARK: Step 2 - Start Camera
        self.cameraView.start()
    }
    
    // Stop session
    override func viewWillDisappear(_ animated: Bool) {
        // MARK: Step 3 - Stop Camera
        self.cameraView.stop()
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

