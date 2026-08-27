//
//  PlayingView.swift
//  PadelPop
//
//  Created by Shem Josh Lowell on 04/05/26.
//

import SwiftUI

struct PlayingView: View {
    @Bindable var viewModel: PadelViewModel
    @State private var scoreScale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black.opacity(0.5), .clear, .black.opacity(0.4)]), startPoint: .top, endPoint: .bottom)
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
                    
                    VStack {
                        Text("SCORE")
                            .font(.system(size: 36, weight: .heavy, design: .default))
                            .foregroundColor(.white)
                            .shadow(color: Color(red: 255/255, green: 84/255, blue: 21/255), radius: 5, x: 0, y: 0)
                        
                        Text("\(viewModel.currentScore)")
                            .font(.system(size: 36, weight: .heavy, design: .default))
                            .foregroundColor(.white)
                            .shadow(color: Color(red: 255/255, green: 84/255, blue: 21/255), radius: 5, x: 0, y: 0)
                        
                        Text("\(viewModel.currentReps) / 25")
                            .font(.system(size: 36, weight: .heavy, design: .default))
                            .foregroundColor(.white)
                            .shadow(color: Color(red: 255/255, green: 84/255, blue: 21/255), radius: 5, x: 0, y: 0)
                    }
                }
                Spacer()
                
                Image("forehand_form1")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 550)
                    .opacity(0.85)
                
                Text("SWING!")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 14)
                    .background(
                        Capsule()
                            .fill(.ultraThinMaterial)
                            .environment(\.colorScheme, .dark)
                    )
                    .padding(.bottom, 20)
            }
        }
    }
}
