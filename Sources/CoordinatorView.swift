//  Created by Alexander Skorulis on 27/4/2025.

import SwiftUI

public struct CoordinatorView: View {

    @State var coordinator: Coordinator
    private let renderers: [any CoordinatorPathRenderer]
    private let overlayRenderers: [CustomOverlay.Name: CustomOverlayRenderer]
    @Environment(\.dismiss) private var dismiss
    private let useNavigationStack: Bool

    public init(
        coordinator: Coordinator,
        renderers: [any CoordinatorPathRenderer] = [],
        overlayRenderers: [CustomOverlay.Name: CustomOverlayRenderer] = [:],
        useNavigationStack: Bool = true,
    ) {
        self.coordinator = coordinator
        self.renderers = renderers
        self.overlayRenderers = overlayRenderers
        self.useNavigationStack = useNavigationStack
    }

    public var body: some View {
        mainContent
        .environment(\.coordinator, coordinator)
        .onChange(of: coordinator.shouldDismiss, { _, newValue in
            if newValue {
                dismiss()
            }
        })
#if canImport(UIKit)
        .fullScreenCover(item: binding(style: .fullScreen)) { presented in
            CoordinatorView(coordinator: presented, renderers: renderers)
        }
#endif
        .sheet(item: binding(style: .sheet)) { presented in
            CoordinatorView(coordinator: presented, renderers: renderers)
        }
        .overlay(
            CustomOverlayView(
                coordinator: coordinator,
                overlays: $coordinator.customOverlays,
                renderers: renderers,
                overlayRenderers: overlayRenderers,
            )
        )
    }

    @ViewBuilder
    private var mainContent: some View {
        if useNavigationStack {
            NavigationStack(path: $coordinator.navPath) {
                render(pathWrapper: coordinator.root)
                    .navigationDestination(for: PathWrapper.self) { path in
                        render(pathWrapper: path)
                    }
            }
        } else {
            // Push navigation is not allowed
            render(pathWrapper: coordinator.root)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
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

    public func with(renderer: any CoordinatorPathRenderer) -> CoordinatorView {
        return CoordinatorView(
            coordinator: coordinator,
            renderers: renderers + [renderer],
            overlayRenderers: overlayRenderers,
            useNavigationStack: useNavigationStack,
        )
    }

    public func with(overlay: CustomOverlay.Name, renderer: @escaping CustomOverlayRenderer) -> CoordinatorView {
        var dict = self.overlayRenderers
        dict[overlay] = renderer
        return CoordinatorView(
            coordinator: coordinator,
            renderers: renderers,
            overlayRenderers: dict,
            useNavigationStack: useNavigationStack,
        )
    }

    private func binding(style: PresentationStyle) -> Binding<Coordinator?> {
        return Binding<Coordinator?> {
            return coordinator.presented?.only(style: style)?.coordinator
        } set: { newValue in
            if newValue == nil && coordinator.presented != nil {
                coordinator.presented = nil
            }
        }
    }
}
