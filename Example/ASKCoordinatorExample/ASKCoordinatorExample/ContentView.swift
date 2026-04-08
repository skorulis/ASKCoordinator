//  Created by Alexander Skorulis on 27/4/2025.

import ASKCoordinator
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        return TabView {
            mainTab
            secondTab
        }
    }
    
    private var mainTab: some View {
        CoordinatorView(coordinator: Coordinator(root: ExamplePath.root))
            .with(renderer: ExamplePathRenderer())
            .with(overlay: .basicDialog) { view, _ in
                AnyView(BasicOverlayDialog(content: { view }))
            }
            .tabItem {
                Label("Main", systemImage: "1.circle")
            }
    }
    
    private var secondTab: some View {
        CoordinatorView(coordinator: Coordinator(root: ExamplePath.viewModelView))
            .with(renderer: ExamplePathRenderer())
            .with(overlay: .basicDialog) { view, _ in
                AnyView(BasicOverlayDialog(content: { view }))
            }
            .tabItem {
                Label("View Model", systemImage: "2.circle")
            }
    }
}

#Preview {
    ContentView()
}
