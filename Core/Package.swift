// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [
        .iOS("17.2")
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "CoreFramework", type: .dynamic, targets: ["NetworkManagement", "Storage", "ProppertyWrappers", "Formatters", "Logger"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "NetworkManagement",
            dependencies: ["Logger"]),
        .target(
            name: "Storage",
            dependencies: []),
        .target(
            name: "ProppertyWrappers",
            dependencies: []),
        .target(
            name: "Formatters",
            dependencies: []),
        .target(
            name: "Logger",
            dependencies: []),
        .testTarget(
            name: "NetworkManagementTests",
            dependencies: ["NetworkManagement"]),
        .testTarget(
            name: "StorageTests",
            dependencies: ["Storage"]),
        .testTarget(
            name: "FormattersTests",
            dependencies: ["Formatters"]),
        .testTarget(
            name: "ProppertyWrappersTests",
            dependencies: ["ProppertyWrappers"])
    ]
)
