//
//  ValidatedInputField.swift
//  Todo
//
//  Created by Illia Suvorov on 10.06.2025.
//

import Foundation
import Combine

public class ValidatedInputField: ObservableObject {
    @Published var value: String = ""
    @Published var errorMessageKey: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    public init(initialValue: String = "") {
        self.value = initialValue
    }
    
    func setupErrorClearingOnValueEditing() {
        $value
            .dropFirst()
            .sink { [weak self] text in
                if text != self?.value {
                    self?.errorMessageKey = nil
                }
            }
            .store(in: &cancellables)
    }
}
