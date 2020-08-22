// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "ExtensionKit",
    platforms: [.iOS(.v8), .macOS(.v10_10), .tvOS(.v9), .watchOS(.v2)],
    products: [
        .library(name: "ExtensionKit", targets: ["ExtensionKit"])
    ],
    targets: [
        .target(
            name: "ExtensionKit",
            exclude: {
                var exclude: [String] = []
                
                #if !canImport(UIKit)
                exclude.append("UIKit")
                #endif
                
                return exclude
            }()
        ),
        .testTarget(
            name: "ExtensionKitTests",
            dependencies: ["ExtensionKit"]
        )
    ]
)
