//  Created by Alexander Skorulis on 27/4/2025.

import ASKCoordinator
import SwiftUI

// MARK: - Memory footprint

struct ViewModelView {
    @State var viewModel: ViewModel
}

// MARK: - Rendering

extension ViewModelView: View {
    
    var body: some View {
        Text("View Model View")
        
        Button(action: viewModel.push) {
            Text("Push View 2")
        }
    }
}

@Observable final class ViewModel {
    
    var coordinator: Coordinator!
    
    func push() {
        coordinator.push(ExamplePath.view2)
    }
}
