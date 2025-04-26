//  Created by Alexander Skorulis on 27/4/2025.

import SwiftUI

/// A path describing a screen inside the coordinator
public protocol CoordinatorPath: Hashable {
    associatedtype CoordinatorType: Coordinator
    var id: String { get }
}

public protocol CoordinatorPathRenderer {
    associatedtype PathType: CoordinatorPath
    
    @MainActor
    func render(path: PathType, in coordinator: PathType.CoordinatorType) -> AnyView
}
