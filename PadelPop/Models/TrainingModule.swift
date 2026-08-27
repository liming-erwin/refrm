//
//  TrainingModule.swift
//  PadelPop
//
//  Created by Liming Erwin Saputra on 04/05/26.
//

import Foundation

struct TrainingModule: Identifiable, Equatable, Hashable {
    let id: UUID
    let name: String
    let thumbnailURL: String
    let category: String
    let isAvailable: Bool
}
