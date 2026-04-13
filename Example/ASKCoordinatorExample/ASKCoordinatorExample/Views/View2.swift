//  Created by Alexander Skorulis on 27/4/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct View2 {
    @Environment(\.coordinator) private var coordinator
}

// MARK: - Rendering

extension View2: View {

    var body: some View {
        VStack {
            Text("View 2")

            Button(action: { coordinator?.retreat()}) {
                Text("Retreat")
            }

            Button(action: { showDialog() }) {
                Text("Show Dialog")
            }
        }
        .navigationTitle("View 2")
    }

    private func showDialog() {
        coordinator?.custom(overlay: .dialog, ExamplePath.overlay)
    }
}
