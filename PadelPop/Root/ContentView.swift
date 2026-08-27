//
//  ContentView.swift
//  PadelPop
//
//  Created by Shem Josh Lowell on 30/04/26.
//  Refactored for Apple HIG compliance.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = PadelViewModel()
    @State private var homeViewModel = TrainingHomeViewModel()

    var body: some View {
        ZStack {
            if viewModel.currentState != .menu {
                VisionCameraContainer(viewModel: viewModel)
                    .ignoresSafeArea()
            }

            Group {
                switch viewModel.currentState {
                case .menu, .finished:
                    TabView {
                        Tab("Train", systemImage: "figure.tennis") {
                            NavigationStack {
                                TrainTabView(
                                    homeViewModel: homeViewModel,
                                    padelViewModel: viewModel
                                )
                                .navigationTitle("Select Technique")
                            }
                        }

                        Tab("History", systemImage: "clock.arrow.circlepath") {
                            NavigationStack {
                                HistoryView(homeViewModel: homeViewModel)
                                    .navigationTitle("History")
                            }
                        }
                    }
                    .tint(Color(.label))

                case .calibrating:
                    CalibrationView(viewModel: viewModel)

                case .playing:
                    PlayingView(viewModel: viewModel)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
