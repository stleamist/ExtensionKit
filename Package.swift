// swift-tools-version:5.1

import PackageDescription

fileprivate var exclude: [String] = []
#if !canImport(UIKit)
exclude.append("UIKit")
#endif

let package = Package(
    name: "ExtensionKit",
    platforms: [.iOS(.v8), .macOS(.v10_10), .tvOS(.v9), .watchOS(.v2)],
    products: [
        .library(name: "ExtensionKit", targets: ["ExtensionKit"])
    ],
    targets: [
        .target(
            name: "ExtensionKit",
            exclude: exclude
        )
    ]
)
