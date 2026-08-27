//
//  TrainingHomeView.swift
//  PadelPop
//
//  Created by Liming Erwin Saputra on 05/05/26.
//

import SwiftUI

struct TrainingHomeView: View {
    var padelViewModel: PadelViewModel
    @State private var homeViewModel = TrainingHomeViewModel()
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    // Header
                    Text("REFRM.")
                        .font(.system(size: 22, weight: .bold).italic())
                        .foregroundColor(Color(red: 232/255, green: 69/255, blue: 10/255))
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                    
                    // Main Card
                    MainCardView(homeViewModel: homeViewModel, padelViewModel: padelViewModel, proxy: proxy)
                        .padding(.horizontal, 5)
                    
                    // Recent Trainings Card
                    RecentTrainingsCardView(homeViewModel: homeViewModel)
                        .padding(.horizontal, 5)
                        .padding(.top, 9)
                        .frame(maxHeight: .infinity, alignment: .top)
                }
                .padding(.bottom, 24)
                .frame(minHeight: proxy.size.height)
            }
            .scrollIndicators(.hidden)
        }
        .background(Color(red: 0.15, green: 0.15, blue: 0.15).ignoresSafeArea())
    }
}



















