//
//  TrainingModuleCardView.swift
//  PadelPop
//
//  Created by Liming Erwin Saputra on 07/05/26.
//

// MARK: - Training Module Card

import SwiftUI

struct TrainingModuleCardView: View {
    let module: TrainingModule
    let isSelected: Bool
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Color(red: 60/255, green: 110/255, blue: 80/255)
            
            Image(module.thumbnailURL)
                .frame(maxWidth: 300, maxHeight: 300)
                .scaleEffect(0.7)
            
            Text(module.name)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.white)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(Color.black.opacity(0.4))
                .cornerRadius(4)
                .padding(8)
        }
        .frame(maxWidth: 300, maxHeight: 300)
        .cornerRadius(12)
        .scaleEffect(isSelected ? 1.0 : 0.95)
        .opacity(module.isAvailable ? 1.0 : 0.4)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected)
    }
}
