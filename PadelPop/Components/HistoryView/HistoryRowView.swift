//
//  HistoryRowView.swift
//  PadelPop
//
//  Created for Apple HIG compliance.
//

import SwiftUI

struct HistoryRowView: View {
    let session: TrainingSession

    var body: some View {
        HStack(spacing: 12) {
            // Leading icon
            Image(systemName: "figure.tennis")
                .font(.title3)
                .foregroundStyle(Color(.secondaryLabel))
                .frame(width: 32, height: 32)

            // Content
            VStack(alignment: .leading, spacing: 2) {
                // Session info — system primary color (no orange)
                Text("\(session.moduleName)  ·  Score: \(session.score)  ·  Reps: \(session.repetitions)")
                    .font(.body)
                    .foregroundStyle(Color(.label))

                // Date — secondary label
                Text(session.date, format: .dateTime.weekday(.wide).day().month(.abbreviated))
                    .font(.caption)
                    .foregroundStyle(Color(.secondaryLabel))
            }

            Spacer()
        }
        .padding(.vertical, 4)
    }
}
