//
//  HomeViewModel.swift
//  Todo
//
//  Created by Illia Suvorov on 09.06.2025.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    private let userStore: UserStore
    
    init(userStore: UserStore) {
        self.userStore = userStore
        
    }
    
    
}
