//
//  ObjectivesRepository.swift
//  Todo
//
//  Created by Illia Suvorov on 04.06.2025.
//

import Foundation

protocol ObjectivesRepository {
    func add(_ objective: Objective) throws
    func remove(_ objective: Objective) throws
    func fetchAll() throws -> [Objective]
}
