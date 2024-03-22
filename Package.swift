// swift-tools-version:5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Monolith",
    platforms: [
       .macOS(.v13),
       .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Monolith",
            targets: ["Monolith"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-crypto", from: "3.3.0"),
        .package(url: "https://github.com/OperatorFoundation/Datable", from: "4.0.1"),
        .package(url: "https://github.com/OperatorFoundation/Song", from: "0.2.7"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Monolith",
            dependencies: [
                "Datable",
                "Song",
                .product(name: "Crypto", package: "swift-crypto")
            ]),
        .testTarget(
            name: "MonolithTests",
            dependencies: ["Monolith", "Datable", "Song"]),
    ]
)
