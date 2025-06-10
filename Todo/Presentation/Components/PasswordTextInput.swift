//
//  PasswordTextInput.swift
//  Todo
//
//  Created by Illia Suvorov on 06.06.2025.
//

import SwiftUI

struct PasswordTextInput: View {
    let title: LocalizedStringKey
    @Binding var text: String
    let onEditingChanged: (Bool) -> Void
    
    init(title: LocalizedStringKey, text: Binding<String>, onEditingChanged: @escaping (Bool) -> Void) {
        self.title = title
        self._text = text
        self.onEditingChanged = onEditingChanged
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            // Invisible but interactive TextField
            TextField(title, text: $text, onEditingChanged: onEditingChanged)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                .modifier(TextInputModifier())
                .autocorrectionDisabled()
                .autocapitalization(.none)
                .textContentType(.password)
                .keyboardType(.asciiCapable)
                .foregroundColor(.clear) // Hide actual text
                .accentColor(.blue) // Keep visible caret
                .font(.system(.body, design: .monospaced))
                
            
            // Overlay with dots or clear text
            Text(String(repeating: "•", count: text.count))
            .font(.system(.body, design: .monospaced))
            .foregroundColor(.primary)
            .padding(.leading, 8)
        }
    }
}

#Preview {
    
    PasswordTextInput(
        title: "password.placeholder",
        text: .constant("")) { _ in
            
        }
}
