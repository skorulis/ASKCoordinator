//  Created by Alexander Skorulis on 16/8/2025.

import Foundation

public protocol CoordinatorViewModel: AnyObject {
    var coordinator: Coordinator? { get set }
}

public extension Coordinator {
    func apply<Obj>(_ obj: Obj) -> Obj {
        (obj as? CoordinatorViewModel)?.coordinator = self
        return obj
    }
}
