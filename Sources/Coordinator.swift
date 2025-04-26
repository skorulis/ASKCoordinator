//  Created by Alexander Skorulis on 27/4/2025.

import SwiftUI

public protocol Coordinator: AnyObject {
    var navPath: NavigationPath { get set }
    var root: PathWrapper { get }
    // var presented: PresentedCoordinator<Self>? { get set }
    
    func push(_ path: any CoordinatorPath)
    func pop()
    // func present(_ path: any CoordinatorPath, style: PresentationStyle)
}

public extension Coordinator {
    func pop() {
        guard !navPath.isEmpty else { return }
        navPath.removeLast()
    }
    
    func push(_ path: any CoordinatorPath) {
        navPath.append(PathWrapper(path: path))
    }
}

public enum PresentationStyle {
    case fullScreen, sheet
}
