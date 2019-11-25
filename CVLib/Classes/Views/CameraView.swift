//
//  CameraView.swift
//  CameraViewApp
//
//  Created by Sri Raghu Malireddi on 2019-11-17.
//  Copyright © 2019 Sri Raghu Malireddi. All rights reserved.
//

import UIKit
import AVFoundation

public protocol CameraBufferDelegate: class {
    func captured(sampleBuffer: CMSampleBuffer)
}

@available(iOS 10.0, *)
public class CameraView: UIView, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    @IBOutlet var cameraView: UIView!
    @IBOutlet weak var cameraBuffer: PreviewView!
    
    // Session - Initialization
    private let session = AVCaptureSession()
    private var isSessionRunning = false
    private let sessionQueue = DispatchQueue(label: "Camera Session Queue", attributes: [], target: nil)
    private var permissionGranted = false
    
    // Nib variables
    let nibName = "CameraView"
    var contentView: UIView!
    
    // Delegate
    weak var delegate: CameraBufferDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.nibName, bundle: bundle)
        self.contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        
        addSubview(cameraView)
        
        cameraView.frame = self.bounds
        cameraView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        // Initialize camera
        initializeCamera()
    }
    
    private func initializeCamera() {
        // Set some features for PreviewView
        cameraBuffer.videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraBuffer.session = session
        
        // Check for permissions
        self.checkPermission()
        
        // Configure Session in session queue
        self.sessionQueue.async { [unowned self] in
            self.configureSession()
        }
    }
    
    // Check for camera permissions
    private func checkPermission() {
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
        case .authorized:
            self.permissionGranted = true
        case .notDetermined:
            self.requestPermission()
        default:
            self.permissionGranted = false
        }
    }
    
    // Request permission if not given
    private func requestPermission() {
        sessionQueue.suspend()
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { [unowned self] granted in
            self.permissionGranted = granted
            self.sessionQueue.resume()
        }
    }
    
    // Configure session properties
    private func configureSession() {
        guard permissionGranted else { return }
        
        self.session.beginConfiguration()
        self.session.sessionPreset = .hd1280x720
        
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back) else { return }
        guard let captureDeviceInput = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        guard self.session.canAddInput(captureDeviceInput) else { return }
        self.session.addInput(captureDeviceInput)
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self as AVCaptureVideoDataOutputSampleBufferDelegate, queue: DispatchQueue(label: "sample buffer"))
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String : kCVPixelFormatType_32BGRA]
        videoOutput.alwaysDiscardsLateVideoFrames = true
        guard self.session.canAddOutput(videoOutput) else { return }
        self.session.addOutput(videoOutput)
        
        self.session.commitConfiguration()
        videoOutput.setSampleBufferDelegate(self as AVCaptureVideoDataOutputSampleBufferDelegate, queue: sessionQueue)
    }
    
    public func start(){
        sessionQueue.async {
            self.session.startRunning()
            self.isSessionRunning = self.session.isRunning
        }
    }
    
    public func stop() {
        sessionQueue.async { [unowned self] in
            if self.permissionGranted {
                self.session.stopRunning()
                self.isSessionRunning = self.session.isRunning
            }
        }
    }
    
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        DispatchQueue.main.async {
            [unowned self] in
            self.delegate?.captured(sampleBuffer: sampleBuffer)
        }
    }
    
}
