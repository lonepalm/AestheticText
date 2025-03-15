// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AestheticText",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
    ],
    products: [
        .library(
            name: "AestheticText",
            targets: ["AestheticText"]
        ),
    ],
    targets: [
        .target(
            name: "AestheticText",
            path: "Sources"
        ),
    ]
)
