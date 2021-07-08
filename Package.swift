// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "ZmcguckinSwift",
    products: [
        .executable(
            name: "ZmcguckinSwift",
            targets: ["ZmcguckinSwift"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.7.0")
    ],
    targets: [
        .target(
            name: "ZmcguckinSwift",
            dependencies: ["Publish"]
        )
    ]
)