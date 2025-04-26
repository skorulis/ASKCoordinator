//  Created by Alexander Skorulis on 27/4/2025.

import SwiftUI

public protocol Coordinator: AnyObject {
    var navPath: NavigationPath { get set }
    // var presented: PresentedCoordinator<Self>? { get set }
    
    func push<Path: CoordinatorPath>(_ path: Path) where Path.CoordinatorType == Self
    func pop()
    func present(_ path: any CoordinatorPath, style: PresentationStyle)
}

public extension Coordinator {
    func pop() {
        guard !navPath.isEmpty else { return }
        navPath.removeLast()
    }
    
    func push<Path: CoordinatorPath>(_ path: Path) where Path.CoordinatorType == Self {
        navPath.append(path)
    }
}

public enum PresentationStyle {
    case fullScreen, sheet
}
