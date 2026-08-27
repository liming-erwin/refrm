//
//  HistoryView.swift
//  PadelPop
//
//  Created for Apple HIG compliance.
//

import SwiftUI

struct HistoryView: View {
    @Bindable var homeViewModel: TrainingHomeViewModel

    var body: some View {
        Group {
            if homeViewModel.recentSessions.isEmpty {
                ContentUnavailableView(
                    "No Training History",
                    systemImage: "clock.arrow.circlepath",
                    description: Text("Your completed training sessions will appear here.")
                )
            } else {
                List(homeViewModel.recentSessions) { session in
                    HistoryRowView(session: session)
                }
                .listStyle(.plain)
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}
