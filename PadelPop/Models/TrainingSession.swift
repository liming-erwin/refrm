//
//  TrainingSession.swift
//  PadelPop
//
//  Created by Liming Erwin Saputra on 04/05/26.
//

import Foundation

struct TrainingSession: Identifiable, Equatable, Hashable {
    let id: UUID
    let moduleId: UUID
    let moduleName: String
    let date: Date
    let score: Int // 0-100
    let repetitions: Int
    let durationSeconds: Int
}
