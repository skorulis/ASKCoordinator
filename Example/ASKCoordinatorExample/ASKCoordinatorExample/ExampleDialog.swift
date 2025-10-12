//  Created by Alexander Skorulis on 12/10/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor struct ExampleDialog<Content: View> {
    var content: () -> Content
    
    @Environment(\.dismissCustomOverlay) private var onDismiss
}

// MARK: - Rendering

extension ExampleDialog: View {
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()
                .onTapGesture {
                    onDismiss()
                }
                .transition(.opacity)
            
            content()
                .padding(.horizontal, 20)
                .padding(.vertical, 40)
                .background(.white)
                .onTapGesture {
                    // Prevent tap from propagating to background
                }
        }
    }
}

struct ExampleDialogModifier: ViewModifier {
    func body(content: Content) -> some View {
        ExampleDialog(content: { content })
    }
}

// MARK: - Previews

#Preview {
    ExampleDialog(content: {
        Text("Testing")
    })
}

