//
//  TextInputModifier.swift
//  Todo
//
//  Created by Illia Suvorov on 04.06.2025.
//

import SwiftUI

struct TextInputModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .tint(.mint)
            .padding([.leading, .trailing], 10)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
    }
}
