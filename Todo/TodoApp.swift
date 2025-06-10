//
//  TodoApp.swift
//  Todo
//
//  Created by Illia Suvorov on 04.06.2025.
//

import SwiftUI
import FirebaseCore
import SimpleRoute

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
      }
}

@main
struct TodoApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    let dependencyContainer = DefaultDependencyContainer()
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }.environment(\.dependancyContainer, dependencyContainer)
    }
}
