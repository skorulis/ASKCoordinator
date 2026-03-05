//  Created by Alexander Skorulis on 27/4/2025.

import ASKCoordinator
import SwiftUI

struct ContentView: View {
    var body: some View {
        CoordinatorView(
            coordinator: Coordinator(root: ExamplePath.root),
            useNavigationStack: true,
        )
        .with(renderer: ExamplePathRenderer())
        .with(overlay: .dialog) { view, _ in
            AnyView(ExampleDialog(content: { view }))
        }
    }
}

#Preview {
    ContentView()
}
