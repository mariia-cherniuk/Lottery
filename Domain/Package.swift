// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Domain",
    platforms: [
        .iOS("17.2")
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "LotteriesDomain",
            type: .dynamic,
            targets: ["LotteriesDomain"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "Core", path: "../Core")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "LotteriesDomain",
            dependencies: [
                .product(name: "NetworkManagement", package: "Core"),
                .product(name: "Storage", package: "Core"),
                .product(name: "ProppertyWrappers", package: "Core"),
                .product(name: "Formatters", package: "Core")
            ]
        ),
        .testTarget(
            name: "LotteriesDomainTests",
            dependencies: ["LotteriesDomain"]),
    ]
)

