//
//  CalibrationView.swift
//  PadelPop
//
//  Created by Shem Josh Lowell on 04/05/26.
//

import SwiftUI

struct CalibrationView: View {
    @Bindable var viewModel: PadelViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black.opacity(0.4), .clear, .black.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        viewModel.resetGame()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2.bold())
                            .foregroundColor(.black)
                            .frame(width: 44, height: 44)
                            .background(Circle().fill(Color.white))
                    }
                    
                    Spacer()
                    
                    Text("FOREHAND")
                        .font(.system(size: 36, weight: .heavy, design: .default))
                        .foregroundColor(Color(red: 255/255, green: 84/255, blue: 21/255))
                        .shadow(color: .black, radius: 2, x: 0, y: 0)
                    
                    Spacer()
                    
                    Circle().frame(width: 44).opacity(0)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Spacer()
                
                Image("forehand_outline")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 550)
                    .opacity(0.85)
                
                Text(viewModel.feedbackText)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 14)
                    .background(Capsule()
                        .fill(viewModel.feedbackText.contains("Succeeded") ? Color(red: 26/255, green: 255/255, blue: 0/255).opacity(0.3) : Color.clear))
                    .background(
                        Capsule()
                            .fill(.ultraThinMaterial)
                            .environment(\.colorScheme, .dark)
                    )
                    .padding(.bottom, 20)
            }
        }
        .onChange(of: viewModel.currentState) { _, newState in
            if newState == .playing {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            }
        }
    }
}
