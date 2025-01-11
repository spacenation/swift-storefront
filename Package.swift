// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Storefront",
    platforms: [
        .iOS(.v17), .macOS(.v14), .tvOS(.v17), .watchOS(.v10)
    ],
    products: [
        .library(name: "Storefront", targets: ["Storefront"])
    ],
    targets: [
        .target(name: "Storefront"),
        .testTarget(name: "StorefrontTests", dependencies: ["Storefront"])
    ]
)
