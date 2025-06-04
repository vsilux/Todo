//
//  LoginView.swift
//  Todo
//
//  Created by Illia Suvorov on 04.06.2025.
//

import SwiftUI

struct LoginView: View {
    private let textFieldHeight: CGFloat = 44
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            TextField("login.email.placeholder", text: $email)
                .frame(height: textFieldHeight)
                .tint(.mint)
                .padding([.leading, .trailing], 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
                
            TextField("login.password.placeholder", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
        }
        .padding()
        .navigationTitle("login.title")
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
