//
//  ErrorMessageButton.swift
//  Todo
//
//  Created by Illia Suvorov on 05.06.2025.
//

import SwiftUI

struct ErrorMessageButton: View {
    @State private var isShowingPopover: Bool = false
    @Binding var errorMessageKey: String?
    
    var body: some View {
        if let errorMessageKey = self.errorMessageKey {
            HStack {
                Spacer()
                Button {
                    self.isShowingPopover.toggle()
                } label: {
                    Image(systemName: "exclamationmark.circle.fill")
                        .tint(.red)
                }
                .popover(
                    isPresented: $isShowingPopover, attachmentAnchor: 
                            .point(.top), arrowEdge: .bottom) {
                                Text(errorMessageKey.localized)
                                    .padding()
                                    .presentationCompactAdaptation(.popover)
                            }
            }
        }
    }
}

#Preview {
    ErrorMessageButton(errorMessageKey: .constant("test"))
}
