//  Created by Alexander Skorulis on 12/10/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor struct ExampleDialog<Content: View> {
    var content: () -> Content
    
    @Environment(\.dismissCustomOverlay) private var onDismiss
    @Environment(\.customOverlayVisible) private var isVisible
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
                .opacity(isVisible ? 1 : 0)
                .scaleEffect(isVisible ? 1 : 0.9)
                .animation(.snappy(duration: 0.25), value: isVisible)
                .onTapGesture {
                    // Prevent tap from propagating to background
                }
        }
    }
}

// MARK: - Previews

#Preview {
    ExampleDialog(content: {
        Text("Testing")
    })
}

