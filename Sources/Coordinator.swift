//  Created by Alexander Skorulis on 27/4/2025.

import SwiftUI

/// The coordinator is responsible for managing navigation between paths
@Observable public final class Coordinator: Identifiable {
    var navPath: NavigationPath = NavigationPath()
    let root: PathWrapper
    var presented: PresentedCoordinator?
    var shouldDismiss: Bool = false
    public var id: String { root.id }
    
    public init(root: any CoordinatorPath) {
        self.root = PathWrapper(path: root)
    }
    
    public var canPop: Bool { !navPath.isEmpty }
    
    /// Pop a path off the navigation stack
    public func pop() {
        guard !navPath.isEmpty else { return }
        navPath.removeLast()
    }
    
    /// Push a path onto the navigation stack
    public func push(_ path: any CoordinatorPath) {
        navPath.append(PathWrapper(path: path))
    }
    
    /// Present a path on top of the current view
    public func present(_ path: any CoordinatorPath, style: PresentationStyle) {
        let coordinator = Coordinator(root: path)
        self.presented = .init(coordinator: coordinator, style: style)
    }
    
    /// Either pop the navigation stack or dismiss
    public func retreat() {
        if !navPath.isEmpty {
            self.pop()
        } else {
            self.dismiss()
        }
    }
    
    /// Dismiss the coordinator (if presented)
    public func dismiss() {
        self.shouldDismiss = true
    }
    
}

struct PresentedCoordinator: Identifiable {
    
    let coordinator: Coordinator
    let style: PresentationStyle
    
    var id: String {
        return coordinator.root.id
    }
    
    init(coordinator: Coordinator, style: PresentationStyle) {
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

/// How to present the given view
public enum PresentationStyle {
    case fullScreen, sheet
}
