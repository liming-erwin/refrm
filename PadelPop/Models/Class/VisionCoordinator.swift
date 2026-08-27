//
//  VisionCoordinator.swift
//  PadelPop
//
//  Created by Shem Josh Lowell on 06/05/26.
//


import SwiftUI
import AVFoundation
import Vision
import CoreMedia

class VisionCoordinator: NSObject, CameraViewControllerDelegate {
    var viewModel: PadelViewModel
    
    init(viewModel: PadelViewModel) {
        self.viewModel = viewModel
    }
    
    func didCaptureFrame(_ sampleBuffer: CMSampleBuffer) {
        let request = VNDetectHumanBodyPose3DRequest(
            completionHandler: processBodyPose
        )
        let handler = VNImageRequestHandler(
            cmSampleBuffer: sampleBuffer,
            orientation: .up,
            options: [:]
        )
        
        do {
            try handler.perform([request])
        } catch {
            print("Vision failed: \(error)")
        }
    }
    
    func processBodyPose(request: VNRequest, error: Error?) {
        guard let observation = request.results?.first as? VNHumanBodyPose3DObservation else {
            return
        }
        
        let rightShoulder = try? observation.recognizedPoint(.rightShoulder)
        let leftShoulder = try? observation.recognizedPoint(.leftShoulder)
        let rightElbow = try? observation.recognizedPoint(.rightElbow)
        let rightWrist = try? observation.recognizedPoint(.rightWrist)
        
        guard let rs = rightShoulder, let ls = leftShoulder, let re = rightElbow, let rw = rightWrist else {
            DispatchQueue.main.async {
                self.viewModel.calibrationStartTime = nil
            }
            return
        }
        
        let cameraMatrix = observation.cameraOriginMatrix
        let distanceZ = abs(cameraMatrix.columns.3.z)
        
        let rShoulderPt = rs.position.columns.3
        let lShoulderPt = ls.position.columns.3
        let elbowPt = re.position.columns.3
        let wristPt = rw.position.columns.3
        
        DispatchQueue.main.async {
            if self.viewModel.currentState == .calibrating {
                let userCenterX = (rShoulderPt.x + lShoulderPt.x) / 2.0
                
                let isCentered = abs(userCenterX) < 0.15
                let isCorrectDistance = distanceZ > 2.0 && distanceZ < 3.0
                
                if userCenterX < -0.15 {
                    self.viewModel.feedbackText = "Move to your Right ➡️"
                } else if userCenterX > 0.15 {
                    self.viewModel.feedbackText = "Move to your Left ⬅️"
                } else if distanceZ < 2.0 {
                    self.viewModel.feedbackText = "Step Back"
                } else if distanceZ > 3.0 {
                    self.viewModel.feedbackText = "Move Closer"
                } else {
                    self.viewModel.feedbackText = "Calibration Succeeded!"
                }
                
                print(
                    String(
                        format: "Center X: %.2f | Distance Z: %.2f",
                        userCenterX,
                        distanceZ
                    )
                )
                
                if isCentered && isCorrectDistance {
                    if self.viewModel.calibrationStartTime == nil {
                        self.viewModel.calibrationStartTime = Date()
                    } else if let startTime = self.viewModel.calibrationStartTime, Date().timeIntervalSince(startTime) > 1.5 {
                        self.viewModel.completeCalibration()
                    }
                } else {
                    self.viewModel.calibrationStartTime = nil
                }
            } else if self.viewModel.currentState == .playing {
                let elbowAngle = self.viewModel.angleBetween3D(
                    first: rShoulderPt,
                    middle: elbowPt,
                    last: wristPt
                )
                
                if elbowAngle > 90 && elbowAngle < 110 {
                    self.viewModel.registerHit()
                }
            }
        }
    }
}