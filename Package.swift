// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "IGListKit",
    platforms: [ .iOS(.v9),
                 .tvOS(.v9),
                 .macOS(.v10_15)
    ],
    products: [
        .library(name: "IGListDiffKit",
                 type: .static ,
                 targets: ["IGListDiffKit"]),
        .library(name: "IGListKit",
                 type: .static,
                 targets: ["IGListKit"]),
        .library(name: "IGListSwiftKit",
                 type: .static,
                 targets: ["IGListSwiftKit"]),
    ],
    targets: [
        .target(
            name: "IGListDiffKit",
            path: "Source/IGListDiffKit",
            publicHeadersPath: ".",
            cSettings: [
                // Xcode
                .headerSearchPath("$SRCROOT/Source"),
                .headerSearchPath("$SRCROOT/Source/IGListDiffKit/Internal"),
                // Package
                .headerSearchPath("../"),
                .headerSearchPath("../Internal"),
                .headerSearchPath("Internal")
            ]
        ),
        .target(
            name: "IGListKit",
            dependencies: ["IGListDiffKit"],
            path: "Source/IGListKit",
            publicHeadersPath: ".",
            cSettings: [
                // Xcode
                .headerSearchPath("$SRCROOT/Source"),
                .headerSearchPath("$SRCROOT/Source/IGListDiffKit/Internal"),
                .headerSearchPath("$SRCROOT/Source/IGListKit/Internal"),
                // Package allows - <XXXX/xx.h> import
                .headerSearchPath("../"),
                // Frameworks private headers with tweak for import.
                .headerSearchPath("Internal"),
                .headerSearchPath("../Internal"),
                // Other private headers
                .headerSearchPath("../IGListDiffKit/Internal"),
                // TWEAK for private imports
                .define("SWIFT_PACKAGE_CONSUMER", to: "1"),
            ]
        ),
        .target(
            name: "IGListSwiftKit",
            dependencies: ["IGListKit"],
            path: "Source/IGListSwiftKit",
            cSettings: [
                .headerSearchPath("../"),
                .headerSearchPath("../IGListDiffKit/Internal"),
                .headerSearchPath("../IGListKit/Internal"),
            ]
        ),
    ],
    cLanguageStandard: .c11,
    cxxLanguageStandard: .cxx11
)
