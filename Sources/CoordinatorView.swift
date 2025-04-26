//  Created by Alexander Skorulis on 27/4/2025.

import SwiftUI


public struct CoordinatorView<T: Coordinator>: View {
    
    @State var coordinator: T
    private let renderers: [any CoordinatorPathRenderer]
    
    public init(coordinator: T, renderers: [any CoordinatorPathRenderer] = []) {
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
    }
    
    private func render(pathWrapper: PathWrapper) -> AnyView {
        let renderer = renderer(for: pathWrapper.path)
        return renderer.render(any: coordinator.root.path, in: coordinator)
    }
    
    private func renderer(for path: any CoordinatorPath) -> any CoordinatorPathRenderer {
        guard let renderer = renderers.first(where: { $0.canRender(path: path)}) else {
            fatalError("Could not find rendered for path \(path)")
        }
        return renderer
    }
    
}


