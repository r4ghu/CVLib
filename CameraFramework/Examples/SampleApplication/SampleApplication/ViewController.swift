//
//  ViewController.swift
//  SampleApplication
//
//  Created by Sri Raghu Malireddi on 2019-12-01.
//  Copyright © 2019 Sri Raghu Malireddi. All rights reserved.
//

import UIKit
import CameraFramework

class ViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let camera = CameraViewController.init()
        camera.position = .back
        present(camera, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

