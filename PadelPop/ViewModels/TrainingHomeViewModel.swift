//
//  TrainingHomeViewModel.swift
//  PadelPop
//
//  Created by Liming Erwin Saputra on 04/05/26.
//

import Foundation
import Observation

@Observable
final class TrainingHomeViewModel {
    // Outputs
    private(set) var modules: [TrainingModule] = []
    private(set) var recentSessions: [TrainingSession] = []
    var selectedModuleId: UUID? = nil
    var repetitionCount: Int = 1
    var isHistoryExpanded: Bool = false
    
    private let maxReps = 200
    private let minReps = 1
    
    // Dummy Data
    init() {
        let forehandModule = TrainingModule(
            id: UUID(uuidString: "11111111-2222-3333-4444-555555555555")!,
            name: "Forehand",
            thumbnailURL: "Forehand",
            category: "Technique",
            isAvailable: true
        )
        let backhandModule = TrainingModule(
            id: UUID(uuidString: "22222222-2222-3333-4444-555555555555")!,
            name: "Backhand",
            thumbnailURL: "Backhand",
            category: "Technique",
            isAvailable: true
        )
        modules = [forehandModule, backhandModule]
        
        // Dummy data using compact Map
        recentSessions = (1...8).map { _ in
            TrainingSession(
                id: UUID(),
                moduleId: forehandModule.id,
                moduleName: forehandModule.name,
                date: Calendar.current.date(from: DateComponents(year: 2026, month: 5, day: 1)) ?? Date(),
                score: 94,
                repetitions: 50,
                durationSeconds: 420
            )
        }
    }
    
    // Inputs
    func incrementReps() {
        if repetitionCount < maxReps {
            repetitionCount += 1
        }
        
//        repetitionCount < maxReps ? repetitionCount += 1 : ()
    }
    
    func decrementReps() {
        if repetitionCount > minReps {
            repetitionCount -= 1
        }
    }
    
    func selectModule(id: UUID) {
        selectedModuleId = id
    }
    
    func startSession() {
        guard let moduleId = selectedModuleId, let module = modules.first(where: { $0.id == moduleId }) else { return }
        let newSession = TrainingSession(
            id: UUID(),
            moduleId: module.id,
            moduleName: module.name,
            date: Date(),
            score: Int.random(in: 60...100),
            repetitions: repetitionCount,
            durationSeconds: Int.random(in: 300...900)
        )
        recentSessions.insert(newSession, at: 0)
    }
    
    func toggleHistory() {
        isHistoryExpanded.toggle()
    }
}
