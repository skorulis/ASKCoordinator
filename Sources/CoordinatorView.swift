//  Created by Alexander Skorulis on 27/4/2025.

import SwiftUI


public struct CoordinatorView: View {
    
    @State var coordinator: Coordinator
    private let renderers: [any CoordinatorPathRenderer]
    
    public init(coordinator: Coordinator, renderers: [any CoordinatorPathRenderer] = []) {
        self.coordinator = coordinator
        self.renderers = renderers
    }
    
    public var body: some View {
        NavigationStack(path: $coordinator.navPath) {
            render(pathWrapper: coordinator.root)
                .navigationDestination(for: PathWrapper.self) { path in
                    render(pathWrapper: path)
                }
        }
        .environment(\.coordinator, coordinator)
#if canImport(UIKit)
        .fullScreenCover(item: binding(style: .fullScreen)) { presented in
            CoordinatorView(coordinator: presented, renderers: renderers)
        }
#endif
        .sheet(item: binding(style: .sheet)) { presented in
            CoordinatorView(coordinator: presented, renderers: renderers)
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
        return CoordinatorView(coordinator: coordinator, renderers: renderers + [renderer])
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


