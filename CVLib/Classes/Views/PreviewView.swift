//  Original work: Copyright © 2019 Apple Inc.
//  Modified work: Copyright © 2019 Sri Raghu Malireddi. All rights reserved.
//
//  File: PreviewView.swift
//  Framework: CVLib
//
//  Abstract:
//  The camera preview view that displays the capture output.

import UIKit
import AVFoundation

class PreviewView: UIView {
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        guard let layer = layer as? AVCaptureVideoPreviewLayer else {
            fatalError("Expected `AVCaptureVideoPreviewLayer` type for layer. Check PreviewView.layerClass implementation.")
        }
        return layer
    }
    
    var session: AVCaptureSession? {
        get {
            return videoPreviewLayer.session
        }
        set {
            videoPreviewLayer.session = newValue
        }
    }
    
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
}
