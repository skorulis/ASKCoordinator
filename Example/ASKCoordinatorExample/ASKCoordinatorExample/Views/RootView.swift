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
        
        Button(action: { coordinator?.push(ExamplePath.viewModelView) }) {
            Text("Push View Model View")
        }
        
        Button(action: { coordinator?.push(ExamplePath.view2) }) {
            Text("Push View 2")
        }
        
        Button(action: { coordinator?.present(ExamplePath.view2, style: .fullScreen) }) {
            Text("Present View 2")
        }
        
        Button(action: { coordinator?.present(ExamplePath.view2, style: .sheet) }) {
            Text("Present View 2 Sheet")
        }
    }
}
