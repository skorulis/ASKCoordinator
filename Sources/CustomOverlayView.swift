//  Created by Alexander Skorulis on 12/10/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor struct CustomOverlayView {
    let coordinator: Coordinator
    @Binding var overlays: [CustomOverlay]
    let renderers: [any CoordinatorPathRenderer]
    let overlayRenderers: [CustomOverlay.Name:  CustomOverlayRenderer]
}

// MARK: - Rendering

extension CustomOverlayView: View {
    
    var body: some View {
        ZStack {
            ForEach(overlays) { overlay in
                overlayRenderers[overlay.name]!(
                    render(pathWrapper: overlay.path)
                )
                .environment(\.dismissCustomOverlay, { dismiss(overlay) })
            }
        }
    }
    
    private func dismiss(_ overlay: CustomOverlay) {
        overlays.removeAll(where: { $0.id == overlay.id })
    }
    
    private func render(pathWrapper: PathWrapper) -> AnyView {
        let renderer = renderer(for: pathWrapper.path)
        return AnyView(renderer.render(any: pathWrapper.path, in: coordinator))
    }
    
    private func renderer(for path: any CoordinatorPath) -> any CoordinatorPathRenderer {
        guard let renderer = renderers.first(where: { $0.canRender(path: path)}) else {
            fatalError("Could not find rendered for path \(path)")
        }
        return renderer
    }
}

extension EnvironmentValues {
    @Entry public var dismissCustomOverlay: () -> Void = {}
}
