// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "DesignKit",
    defaultLocalization: "pl",
    platforms: [.macOS(.v26), .iOS(.v26)],
    products: [
        .library(name: "DesignKit", targets: ["DesignKit"]),
        .library(name: "DesignSystem", targets: ["DesignSystem"]),
    ],
    targets: [
        .target(name: "DesignKit"),
        .target(
            name: "DesignSystem",
            dependencies: ["DesignKit"],
            resources: [.process("Resources")]
        ),
    ]
)
