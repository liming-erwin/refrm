//
//  RecentTrainingCardView.swift
//  PadelPop
//
//  Created by Liming Erwin Saputra on 07/05/26.
//

// MARK: - Recent Training Cell

import SwiftUI

struct RecentTrainingCardView: View {
    let session: TrainingSession
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "figure.tennis")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(.gray)
                .frame(width: 44, height: 44)
                .padding(.leading, 20)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 0) {
                    Text("Score: ")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.black)
                    Text("\(session.score)")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(Color(red: 232/255, green: 69/255, blue: 10/255))
                    Text("  |  Repetition: ")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.black)
                    Text("\(session.repetitions)")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(Color(red: 232/255, green: 69/255, blue: 10/255))
                }
                
                Text(session.date, format: .dateTime.weekday(.wide).day().month(.abbreviated))
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .frame(height: 84)
        .background(Color.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}
