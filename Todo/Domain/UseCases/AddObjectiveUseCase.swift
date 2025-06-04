//
//  AddObjectiveUseCase.swift
//  Todo
//
//  Created by Illia Suvorov on 04.06.2025.
//

import Foundation

protocol AddObjectiveUseCase {
    func add(objective title: String, description: String?, dueDate: Date) throws
}

enum AddObjectiveError: Error {
    case titleTooShort
}

class AddObjectiveInteractor: AddObjectiveUseCase {
    private let minimumTitleLength = 3
    let repository: ObjectivesRepository
    
    init(repository: ObjectivesRepository) {
        self.repository = repository
    }
    
    func add(objective title: String, description: String?, dueDate: Date) throws {
        if title.count < minimumTitleLength {
            throw AddObjectiveError.titleTooShort
        }
        
        let objective = Objective(title: title, description: description, dueDate: dueDate)
        
        try repository.add(objective)
    }
}
