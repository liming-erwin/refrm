//
//  MainCardView.swift
//  PadelPop
//
//  Created by Liming Erwin Saputra on 07/05/26.
//

// MARK: - Main Card Component

import SwiftUI

struct MainCardView: View {
    var homeViewModel: TrainingHomeViewModel
    var padelViewModel: PadelViewModel
    
    @State private var scrolledID: UUID?
    let proxy: GeometryProxy
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Modules Carousel
            moduleCarousel
            // Page Control
            HStack(spacing: 8) {
                ForEach(homeViewModel.modules) { module in
                    Circle()
                        .fill(scrolledID == module.id ? Color(white: 0.3) : Color(white: 0.8))
                        .frame(width: 8, height: 8)
                        .animation(.easeInOut, value: scrolledID)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 8)
            
            // Reps & Start Controls
            SessionConfigurationView(homeViewModel: homeViewModel, padelViewModel: padelViewModel)
                .padding(.top, 16)
                .padding(.bottom, 24)
        }
        .background(Color.white)
        .cornerRadius(32)
    }
    
    @ViewBuilder
    private var moduleCarousel: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(homeViewModel.modules) { module in
                    TrainingModuleCardView(module: module, isSelected: homeViewModel.selectedModuleId == module.id)
                        .containerRelativeFrame(.horizontal, count: 3, span: 3, spacing: 10)
                        .scrollTransition(.animated(.spring(duration: 0.4))) { content, phase in
                            content
                                .scaleEffect(phase.isIdentity ? 1.0 : 0.92)
                                .opacity(phase.isIdentity ? 1.0 : 0.65)
                        }
                        .onTapGesture {
                            if module.isAvailable {
                                homeViewModel.selectModule(id: module.id)
                            }
                        }
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollPosition(id: $scrolledID)
        .safeAreaPadding(.horizontal, 10)
        .frame(height: 380)
        .padding(.top, 20)
        .onAppear {
            if scrolledID == nil {
                scrolledID = homeViewModel.modules.first?.id
            }
        }
        .onChange(of: scrolledID) { oldValue, newValue in
            guard let newID = newValue else { return }
            if let module = homeViewModel.modules.first(where: { $0.id == newID }),
               module.isAvailable {
                homeViewModel.selectModule(id: newID)
            }
        }
    }
}
