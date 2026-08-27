//
//  CameraViewController.swift
//  PadelPop
//
//  Created by Shem Josh Lowell on 06/05/26.
//


import SwiftUI
import AVFoundation
import Vision
import CoreMedia

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    weak var delegate: CameraViewControllerDelegate?
    private let captureSession = AVCaptureSession()
    private let videoQueue = DispatchQueue(
        label: "videoQueue",
        qos: .userInteractive
    )
    private var previewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }
    
    private func setupCamera() {
        captureSession.beginConfiguration()
        captureSession.sessionPreset = .high
        
        let discoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera, .builtInTrueDepthCamera],
            mediaType: .video,
            position: .front
        )
        
        guard let videoDevice = discoverySession.devices.first,
              let videoInput = try? AVCaptureDeviceInput(device: videoDevice) else {
            print("Cant access camera bridge 1")
            captureSession.commitConfiguration()
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            print("Cant add input")
            captureSession.commitConfiguration()
            return
        }
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(
            kCVPixelFormatType_32BGRA
        )]
        videoOutput.alwaysDiscardsLateVideoFrames = true
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
            //            videoOutput.connection(with: .video)?.isVideoMirrored = false
        } else {
            print("Bridge 2 error")
            captureSession.commitConfiguration()
            return
        }
        
        captureSession.commitConfiguration()
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.bounds
        //        previewLayer.connection?.automaticallyAdjustsVideoMirroring = false
        //        previewLayer.connection?.isVideoMirrored = false
        view.layer.addSublayer(previewLayer)
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
    }
    
    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        delegate?.didCaptureFrame(sampleBuffer)
    }
}