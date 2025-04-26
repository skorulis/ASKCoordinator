//  Created by Alexander Skorulis on 27/4/2025.

import SwiftUI

@Observable public final class Coordinator: Identifiable {
    var navPath: NavigationPath = NavigationPath()
    let root: PathWrapper
    var presented: PresentedCoordinator?
    public var id: String { root.id }
    
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
    
    public func present(_ path: any CoordinatorPath, style: PresentationStyle) {
        let coordinator = Coordinator(root: path)
        self.presented = .init(coordinator: coordinator, style: style)
    }
    
    
}

public struct PresentedCoordinator: Identifiable {
    
    public let coordinator: Coordinator
    public let style: PresentationStyle
    
    public var id: String {
        return coordinator.root.id
    }
    
    public init(coordinator: Coordinator, style: PresentationStyle) {
        self.coordinator = coordinator
        self.style = style
    }
    
    func only(style: PresentationStyle) -> Self? {
        switch (self.style, style) {
        case (.fullScreen, .fullScreen): return self
        case (.sheet, .sheet): return self
        default: return nil
        }
    }
    
}

public enum PresentationStyle {
    case fullScreen, sheet
}
