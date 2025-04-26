//  Created by Alexander Skorulis on 27/4/2025.

import SwiftUI

/// A path describing a screen inside the coordinator
public protocol CoordinatorPath {
    associatedtype CoordinatorType: Coordinator
    var id: String { get }
}

public protocol CoordinatorPathRenderer {
    associatedtype PathType: CoordinatorPath
    
    @MainActor
    func render(path: PathType, in coordinator: Coordinator) -> AnyView
}

extension CoordinatorPathRenderer {
    @MainActor
    func render(any path: any CoordinatorPath, in coordinator: Coordinator) -> AnyView {
        let path = path as! Self.PathType
        return render(path: path, in: coordinator)
    }
}

extension CoordinatorPathRenderer {
    func canRender(path: any CoordinatorPath) -> Bool {
        return type(of: path) == type(of: self).PathType
    }
}

public struct PathWrapper: Hashable {
    
    let path: any CoordinatorPath
    
    public init(path: any CoordinatorPath) {
        self.path = path
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(path.id)
    }
    
    public static func == (lhs: PathWrapper, rhs: PathWrapper) -> Bool {
        return lhs.path.id == rhs.path.id
    }
    
    var id: String {
        return path.id
    }
    
}
