//  Created by Alexander Skorulis on 8/4/2026.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor public struct BasicOverlayDialog<Content: View> {
    var content: () -> Content
    
    public init(content: @escaping () -> Content) {
        self.content = content
    }
    
    @Environment(\.dismissCustomOverlay) private var onDismiss
    @Environment(\.customOverlayVisible) private var isVisible
}

// MARK: - Rendering

extension BasicOverlayDialog: View {
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()
                .onTapGesture {
                    onDismiss()
                }
                .transition(.opacity)
            
            content()
                .opacity(isVisible ? 1 : 0)
                .scaleEffect(isVisible ? 1 : 0.9)
                .animation(.snappy(duration: 0.25), value: isVisible)
                .onTapGesture {
                    // Prevent tap from propagating to background
                }
        }
    }
}

extension CustomOverlay.Name {
    public static let basicDialog = CustomOverlay.Name("basicDialog")
}
