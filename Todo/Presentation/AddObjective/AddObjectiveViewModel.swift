//
//  AddObjectiveViewModel.swift
//  Todo
//
//  Created by Illia Suvorov on 04.06.2025.
//

import Foundation

class AddObjectiveViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var dueDate: Date = Date()
    
    func addObjective() {
        // Logic to add the objective
        var objective = Objective(
            title: title,
            description: description.isEmpty ? nil : description,
            dueDate: dueDate
        )
    }
}
