//
//  Environment+DI.swift
//  Todo
//
//  Created by Illia Suvorov on 10.06.2025.
//

import SwiftUI

struct DependencyContainerKey: EnvironmentKey {
    nonisolated(unsafe) static let defaultValue: DependencyContainer = DefaultDependencyContainer()
}

extension EnvironmentValues {
    var dependancyContainer: DependencyContainer {
        get { self[DependencyContainerKey.self] }
        set { self[DependencyContainerKey.self] = newValue }
    }
}
