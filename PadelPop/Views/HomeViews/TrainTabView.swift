//
//  TrainTabView.swift
//  PadelPop
//
//  Refactored for Apple HIG compliance.
//

import SwiftUI

struct TrainTabView: View {
    @Bindable var homeViewModel: TrainingHomeViewModel
    @Bindable var padelViewModel: PadelViewModel

    @State private var scrolledID: UUID?
    @FocusState private var isKeyboardFocused: Bool

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // MARK: - Technique Carousel
                techniqueCarousel

                // MARK: - Page Indicator
                pageIndicator

                // MARK: - Session Configuration
                sessionConfiguration
            }
            .padding(.bottom, 32)
        }
        .scrollIndicators(.hidden)
        .background(Color(.systemGroupedBackground))
        
    }

    // MARK: - Technique Carousel

    private var techniqueCarousel: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(homeViewModel.modules) { module in
                    TrainingModuleCardView(
                        module: module,
                        isSelected: homeViewModel.selectedModuleId == module.id
                    )
                    .containerRelativeFrame(.horizontal, count: 3, span: 3, spacing: 16)
                    .scrollTransition { content, phase in
                                        content
                                            .opacity(phase.isIdentity ? 1.0 : 0.6)
                                            .scaleEffect(phase.isIdentity ? 1.0 : 0.92)
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollPosition(id: $homeViewModel.selectedModuleId)
        .safeAreaPadding(.horizontal, 16)
        .frame(height: 380)
        .onAppear {
            if scrolledID == nil {
                scrolledID = homeViewModel.modules.first?.id
            }
        }
    }

    // MARK: - Page Indicator

    private var pageIndicator: some View {
        HStack(spacing: 8) {
            ForEach(homeViewModel.modules) { module in
                Circle()
                    .fill(scrolledID == module.id ? Color(.label) : Color(.tertiaryLabel))
                    .frame(width: 8, height: 8)
                    .animation(.easeInOut, value: scrolledID)
            }
        }
    }

    // MARK: - Session Configuration

    private var sessionConfiguration: some View {
        VStack(spacing: 24) {
            // Input Reps
            HStack {
                Text("Reps")
                    .font(.body)
                    .fontWeight(.medium)
                
                Spacer()
                
                TextField("10", value: $homeViewModel.repetitionCount, format: .number)
                    .keyboardType(.numberPad)
                    .focused($isKeyboardFocused)
                    .multilineTextAlignment(.trailing)
                    .font(.system(.title3, design: .rounded).bold())
                    .foregroundColor(isKeyboardFocused ? .orange : .primary)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 20)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color(.systemGray6))
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(isKeyboardFocused ? Color.orange.opacity(0.5) : Color.clear, lineWidth: 2)
                            )
                    )
                    .frame(width: 120)
                    .onChange(of: homeViewModel.repetitionCount) { _, newValue in
                        if newValue > 200 {
                            homeViewModel.repetitionCount = 200
                        }
                    }
            }
            .padding(.horizontal, 16)
            
            // Start Button
            Button(action: {
                startTrainingAction()
            }) {
                Text("Start")
                    .font(.headline)
                    .frame(maxWidth: .infinity, minHeight: 44)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color(red: 232/255, green: 69/255, blue: 10/255))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .disabled(homeViewModel.selectedModuleId == nil)
            .opacity(homeViewModel.selectedModuleId == nil ? 0.4 : 1.0)
            .padding(.horizontal, 16)
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                // Spacer ini penting buat dorong tombol ke kanan
                Spacer()
                
                Button("Done") {
                    validateAndDismiss()
                }
                .fontWeight(.bold)
                .tint(.orange)
            }
        }
        .padding(.bottom, isKeyboardFocused ? 60 : 0)
        .animation(.smooth(duration: 0.3), value: isKeyboardFocused)
    }

    // MARK: - Helper Functions
    
    private func validateAndDismiss() {
        if homeViewModel.repetitionCount < 1 {
            homeViewModel.repetitionCount = 1
        }
        isKeyboardFocused = false
    }
    
    private func startTrainingAction() {
        homeViewModel.startSession()
        if let module = homeViewModel.modules.first(where: { $0.id == homeViewModel.selectedModuleId }) {
            padelViewModel.startGame(with: PadelForm(name: module.name, description: module.category))
        } else {
            padelViewModel.startGame(with: PadelForm(name: "Forehand", description: "Technique"))
        }
    }
}
