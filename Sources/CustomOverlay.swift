//  Created by Alexander Skorulis on 12/10/2025.

import Foundation
import SwiftUI

public struct CustomOverlay: Identifiable {
    let name: CustomOverlay.Name
    let path: PathWrapper
    
    public var id: String {
        return "\(name.name)-\(path.id)"
    }
}

public typealias CustomOverlayRenderer = (AnyView) -> AnyView

extension CustomOverlay {
    public struct Name: Equatable, Hashable {
        let name: String
        
        public init(_ name: String) {
            self.name = name
        }
    }

}

