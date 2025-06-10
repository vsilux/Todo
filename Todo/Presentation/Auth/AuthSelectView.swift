//
//  InitialScreen.swift
//  Todo
//
//  Created by Illia Suvorov on 08.06.2025.
//

import SwiftUI
import Combine

struct AuthSelectView: View {
    @Environment(\.router) private var router
    @Environment(\.dependancyContainer) var container
        
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Text(LocalizedKey.Auth.message.localized)
                .font(.system(size: 32))
                .padding()
                    
            Spacer()
                
            Button {
                router.navigate(to: LoginRoute(dependencyContainer: container))
            } label: {
                Text(LocalizedKey.Login.title.localized)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .frame(height: Constants.textFieldHeight)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(.mint)
            )
            .padding()
                
            Button {
                router.navigate(to: SignupRoute(dependencyContainer: container))
            } label: {
                Text(LocalizedKey.Signup.title.localized)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .frame(height: Constants.textFieldHeight)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(.mint)
            )
            .padding(.horizontal, 16)
            .safeAreaPadding(.bottom, 40)
        }
    }
}

#Preview {
    AuthSelectView()
}
