// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ASKCoordinator",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "ASKCoordinator",
            targets: ["ASKCoordinator"]),
    ],
    dependencies: [
        .package(url: "https://github.com/cashapp/knit.git", exact: "2.0.1")
    ],
    targets: [
        .target(
            name: "ASKCoordinator",
            dependencies: [
                .product(name: "Knit", package: "knit")
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "ASKCoreUnitTests",
            dependencies: ["ASKCore"],
            path: "UnitTests"
            ),
    ]
)
