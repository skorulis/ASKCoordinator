//  Created by Alexander Skorulis on 27/4/2025.

import ASKCoordinator

enum ExamplePath: CoordinatorPath {
    typealias CoordinatorType = ExampleCoordinator
    
    case root
    
    var id: String {
        switch self {
        case .root: return "Root"
        }
    }
}
