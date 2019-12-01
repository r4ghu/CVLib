//
//  CameraViewController.swift
//  CameraFramework
//
//  Created by Sri Raghu Malireddi on 2019-12-01.
//  Copyright © 2019 Sri Raghu Malireddi. All rights reserved.
//

import UIKit
import AVFoundation

public final class CameraViewController: UIViewController {
    
    var session = AVCaptureSession()
    var discoverySession: AVCaptureDevice.DiscoverySession?
    {
        return AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
    }
    var videoOutput = AVCaptureVideoDataOutput()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        createUI()
        commitConfiguration()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be activated
    }
    
    func createUI() {
        self.view.layer.addSublayer(getPreviewLayer(session: self.session))
    }
    
    func commitConfiguration() {
        do {
            guard let device = getDevice() else { return }
            let input = try AVCaptureDeviceInput(device: device)
            if self.session.canAddInput(input) && self.session.canAddOutput(self.videoOutput) {
                self.session.addInput(input)
                self.session.addOutput(self.videoOutput)
                self.session.commitConfiguration()
                self.session.startRunning()
            }
        } catch {
            print("ERROR: Linking device to AVInput.")
        }
    }
    
    func getPreviewLayer(session: AVCaptureSession) -> AVCaptureVideoPreviewLayer {
        let previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
        previewLayer.frame = self.view.bounds
        return previewLayer
    }
    
    func getDevice() -> AVCaptureDevice? {
        guard let discoverySession = self.discoverySession else { return nil }
        
        for device in discoverySession.devices {
            if device.position == AVCaptureDevice.Position.back {
                return device
            }
        }
        
        return nil
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
