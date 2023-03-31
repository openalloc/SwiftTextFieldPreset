// swift-tools-version: 5.7

import PackageDescription

let package = Package(name: "SwiftTextFieldPreset",
                      platforms: [.macOS(.v13), .iOS(.v16), .watchOS(.v9)],
                      products: [
                          .library(name: "TextFieldPreset",
                                   targets: ["TextFieldPreset"]),
                      ],
                      dependencies: [
                          .package(url: "https://github.com/apple/swift-collections.git", from: "1.0.4"),
                      ],
                      targets: [
                          .target(name: "TextFieldPreset",
                                  dependencies: [
                                      .product(name: "Collections", package: "swift-collections"),
                                  ],
                                  path: "Sources",
                                  resources: [
                                      .process("Resources"),
                                  ]),
//                          .testTarget(name: "TextFieldPresetTests",
//                                      dependencies: ["TextFieldPreset"],
//                                      path: "Tests"),
                      ])
