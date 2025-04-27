//  Created by Alexander Skorulis on 27/4/2025.

import ASKCoordinator
import SwiftUI

enum ExamplePath: CoordinatorPath {
    
    /// The root view at the bottom of the stack
    case root
    
    /// A view demonstating using a view model for navigation
    case viewModelView
    
    ///  A terminal view with only the ability to go back
    case view2
    
    var id: String {
        return String(describing: self)
    }
}

struct ExamplePathRenderer: CoordinatorPathRenderer {
    typealias PathType = ExamplePath
    
    @ViewBuilder
    func render(path: ExamplePath, in coordinator: Coordinator) -> some View {
        switch path {
        case .root:
            RootView()
        case .viewModelView:
            viewModelView(coordinator: coordinator)
        case .view2:
            View2()
        }
    }
    
    private func viewModelView(coordinator: Coordinator) -> some View {
        let vm = ViewModel()
        vm.coordinator = coordinator
        return ViewModelView(viewModel: vm)
    }
}
