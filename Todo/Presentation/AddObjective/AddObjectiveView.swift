//
//  AddObjectiveView.swift
//  Todo
//
//  Created by Illia Suvorov on 04.06.2025.
//

import SwiftUI

struct AddObjectiveView: View {
    @StateObject private var viewModel = AddObjectiveViewModel()
    
    var body: some View {
        Form {
            Section {
                TextField(
                    "objective.title",
                    text: $viewModel.title
                )
                DatePicker(
                    "objective.dueDate",
                    selection: $viewModel.dueDate,
                    displayedComponents: [.hourAndMinute, .date]
                )
                TextField(
                    "objective.description",
                    text: $viewModel.description,
                    axis: .vertical
                )
            }
            Button("objective.add") {
            }
        }
        .contentMargins(.top, 20)
        .navigationTitle("Add Objective")
    }
}

#Preview {
    NavigationStack {
        AddObjectiveView()
    }
}
