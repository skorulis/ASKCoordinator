//  Created by Alexander Skorulis on 27/4/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct RootView {
    @Environment(\.coordinator) private var coordinator
}

// MARK: - Rendering

extension RootView: View {
    
    var body: some View {
        Text("Root")
        Button(action: { coordinator?.push(ExamplePath.view2) }) {
            Text("Push")
        }
    }
}
