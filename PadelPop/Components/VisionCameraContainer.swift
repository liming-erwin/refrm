//
//  VisionCameraContainer.swift
//  PadelPop
//
//  Created by Shem Josh Lowell on 04/05/26.
//

import SwiftUI
import AVFoundation
import Vision
import CoreMedia

struct VisionCameraContainer: UIViewControllerRepresentable {
    var viewModel: PadelViewModel
    
    func makeUIViewController(context: Context) -> CameraViewController {
        let controller = CameraViewController()
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(
        _ uiViewController: CameraViewController,
        context: Context
    ) {
    }
    
    func makeCoordinator() -> VisionCoordinator {
        VisionCoordinator(viewModel: viewModel)
    }
}




