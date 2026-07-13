// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "do_not_disturb",
  platforms: [
    .iOS("12.0")
  ],
  products: [
    // If the plugin name contains "_", replace with "-" for the library name.
    .library(name: "do-not-disturb", targets: ["do_not_disturb"])
  ],
  dependencies: [],
  targets: [
    .target(
      name: "do_not_disturb",
      dependencies: [],
      resources: [
        // Bundles the privacy manifest so it is available when the plugin is
        // consumed via Swift Package Manager.
        .process("PrivacyInfo.xcprivacy")
      ]
    )
  ]
)
