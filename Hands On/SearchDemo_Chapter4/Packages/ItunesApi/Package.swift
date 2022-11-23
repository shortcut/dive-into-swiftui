// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: " ItunesApi",
    defaultLocalization: "en",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "ItunesApi",
            targets: ["ItunesApi"])
    ],
    dependencies: [
        //            .package(url: "https://github.com/SwiftGen/SwiftGenPlugin", from: "6.6.0")
    ],
    targets: [
        .target(name: "ItunesApi",
                plugins: [
                    //                    .plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin")
                ])
    ]
)
