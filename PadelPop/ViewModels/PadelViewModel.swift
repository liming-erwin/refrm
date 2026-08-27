//
//  PadelViewModel.swift
//  PadelPop
//
//  Created by Shem Josh Lowell on 01/05/26.
//

import SwiftUI
import CoreGraphics
import Observation
import simd

@Observable
class PadelViewModel {
    var currentState: AppState = .menu
    var selectedForm: PadelForm? = nil
    var currentScore: Int = 0
    var feedbackText: String = "Ready!"
    var calibrationStartTime: Date? = nil
    var currentReps: Int = 0
    
    var debugPoints: [CGPoint] = []
    
    func startGame(with form: PadelForm) {
        self.selectedForm = form
        self.currentState = .calibrating
        self.currentScore = 0
        self.currentReps = 0
        self.feedbackText = "Fit your body inside the outline"
    }
    
    func completeCalibration() {
        if currentState == .calibrating {
            currentState = .playing
            feedbackText = "SWING!"
        }
    }
    
    func registerHit() {
        if currentState == .playing {
            currentScore += 100
            currentReps += 1
            feedbackText = "Perfect!"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if self.currentState == .playing {
                    self.feedbackText = "Ready for next swing..."
                }
            }
        }
    }
    
    func resetGame() {
        self.currentState = .menu
        self.selectedForm = nil
        self.currentScore = 0
        self.currentReps = 0
        self.calibrationStartTime = nil
    }
}

extension PadelViewModel {
    func angleBetween3D(first: simd_float4, middle: simd_float4, last: simd_float4) -> CGFloat {
        let vectorA = simd_float3(first.x - middle.x, first.y - middle.y, first.z - middle.z)
        let vectorB = simd_float3(last.x - middle.x, last.y - middle.y, last.z - middle.z)
        
        let normA = simd_normalize(vectorA)
        let normB = simd_normalize(vectorB)
        
        let dotProduct = simd_dot(normA, normB)
        
        let clampedDot = max(-1.0, min(1.0, dotProduct))
        let angleRadians = acos(clampedDot)
        
        return CGFloat(angleRadians * 180.0 / .pi)
    }
}
