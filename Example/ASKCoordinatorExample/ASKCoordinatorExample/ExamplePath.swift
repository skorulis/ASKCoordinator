//  Created by Alexander Skorulis on 27/4/2025.

import ASKCoordinator
import SwiftUI

enum ExamplePath: CoordinatorPath {
    typealias CoordinatorType = ExampleCoordinator
    
    case root
    case view2
    
    var id: String {
        switch self {
        case .root: return "Root"
        case .view2: return "View2"
        }
    }
}

struct ExamplePathRenderer: CoordinatorPathRenderer {
    typealias PathType = ExamplePath
    
    @ViewBuilder
    func render(path: ExamplePath, in coordinator: any ASKCoordinator.Coordinator) -> some View {
        switch path {
        case .root:
            RootView()
        case .view2:
            Text("View 2")
        }
    }
}
