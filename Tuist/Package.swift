// swift-tools-version: 5.9
import PackageDescription
let projectName = "dg-muscle-ios"

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
//        productTypes: ["Firebase": .framework]
    )
#endif

let package = Package(
    name: projectName,
    dependencies: [
        // You can read more about dependencies here: https://docs.tuist.io/documentation/tuist/dependencies
//        .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "10.15.0")
    ]
)
