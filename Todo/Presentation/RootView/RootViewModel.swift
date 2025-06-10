//
//  RootViewModel.swift
//  Todo
//
//  Created by Illia Suvorov on 09.06.2025.
//

import Foundation
import Combine

class RootViewModel: ObservableObject {
    private let authService: AuthService
    private let userStore: UserStore
    @Published var isLoading: Bool = true
    @Published var user: User? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    init(authService: AuthService, userStore: UserStore) {
        self.authService = authService
        self.userStore = userStore
        userStore.userPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
            self?.user = user
        }.store(in: &cancellables)
    }
    
    func checkIsAuthorized() {
        isLoading = true
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            userStore.store(self.authService.user)
            self.isLoading = false
        }
    }
}
