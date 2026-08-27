//
//  CameraViewControllerDelegate.swift
//  PadelPop
//
//  Created by Shem Josh Lowell on 06/05/26.
//


import SwiftUI
import AVFoundation
import Vision
import CoreMedia

protocol CameraViewControllerDelegate: AnyObject {
    func didCaptureFrame(_ sampleBuffer: CMSampleBuffer)
}