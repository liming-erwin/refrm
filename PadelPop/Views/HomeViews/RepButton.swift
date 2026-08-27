//
//  RepButton.swift
//  PadelPop
//
//  Created by Liming Erwin Saputra on 06/05/26.
//

// Custom Gesture Button for Reps

import SwiftUI

struct RepButton: View {
    let title: String
    let action: () -> Void
    
    @State private var timer: Timer?
    @State private var isPressed = false
    
    var body: some View {
        Text(title)
            .font(.system(size: 32, weight: .bold))
            .foregroundColor(.black)
            .frame(width: 44, height: 44)
            .contentShape(Rectangle())
            .opacity(isPressed ? 0.5 : 1.0)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if !isPressed {
                            isPressed = true
                            action() // Fire once immediately
                            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in action() }
                        }
                    }
                    .onEnded { _ in
                        isPressed = false
                        timer?.invalidate()
                        timer = nil
                    }
            )
    }
}
