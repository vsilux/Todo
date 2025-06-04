//
//  Objective.swift
//  Todo
//
//  Created by Illia Suvorov on 04.06.2025.
//

import Foundation

struct Objective: Identifiable, Codable {
    let id: UUID
    var title: String
    var description: String?
    var isCompleted: Bool
    var dueDate: Date
    var createdAt: Date
    
    init(
        id: UUID = UUID(),
        title: String,
        description: String? = nil,
        isCompleted: Bool = false,
        dueDate: Date,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
        self.dueDate = dueDate
        self.createdAt = createdAt
    }
}
