//
//  RecentTrainingsCardView.swift
//  PadelPop
//
//  Created by Liming Erwin Saputra on 07/05/26.
//

// MARK: - Recent Trainings Section

import SwiftUI

struct RecentTrainingsCardView: View {
    var homeViewModel: TrainingHomeViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Recent Trainings")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.black)
                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        homeViewModel.toggleHistory()
                    }
                }) {
                    Text(homeViewModel.isHistoryExpanded ? "View Less ˄" : "View More ˅")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            
            VStack(spacing: 0) {
                let maxRows = homeViewModel.isHistoryExpanded ? homeViewModel.recentSessions.count : min(homeViewModel.recentSessions.count, 1)
                
                ForEach(homeViewModel.recentSessions.prefix(maxRows)) { session in
                    RecentTrainingCardView(session: session)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                }
            }
            
            Spacer(minLength: 0)
        }
        .background(Color.white)
        .cornerRadius(32)
    }
}

