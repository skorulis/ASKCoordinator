//  Created by Alexander Skorulis on 6/11/2022.

import Foundation
import SwiftUI

public struct CoordinatorKey: EnvironmentKey {
    public static var defaultValue: (Coordinator)? = nil
}

public extension EnvironmentValues {
    
    var coordinator: (Coordinator)? {
        get { self[CoordinatorKey.self] }
        set { self[CoordinatorKey.self] = newValue }
    }
}


