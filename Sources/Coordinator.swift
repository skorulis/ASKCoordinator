//  Created by Alexander Skorulis on 27/4/2025.

import SwiftUI

@Observable public final class Coordinator {
    var navPath: NavigationPath = NavigationPath()
    let root: PathWrapper
    // var presented: PresentedCoordinator<Self>? { get set }
    
    public init(root: any CoordinatorPath) {
        self.root = PathWrapper(path: root)
    }
    
    public func pop() {
        guard !navPath.isEmpty else { return }
        navPath.removeLast()
    }
    
    public func push(_ path: any CoordinatorPath) {
        navPath.append(PathWrapper(path: path))
    }
    
    // func present(_ path: any CoordinatorPath, style: PresentationStyle)
}

public enum PresentationStyle {
    case fullScreen, sheet
}
