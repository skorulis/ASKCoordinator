//  Created by Alexander Skorulis on 27/4/2025.

import ASKCoordinator
import SwiftUI

@Observable final class ExampleCoordinator: Coordinator {    
    var navPath: NavigationPath = NavigationPath()
    
    var root: PathWrapper
    
    init() {
        root = PathWrapper(path: ExamplePath.root)
    }
}
