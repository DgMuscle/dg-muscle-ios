import ProjectDescription

let projectName = "dg-muscle-ios"
let bundleName = "com.donggyu.dg-muscle-ios"

let project = Project(
    name: projectName,
    packages: [
        .remote(url: "https://github.com/firebase/firebase-ios-sdk", requirement: .upToNextMajor(from: "10.15.0"))
    ],
    settings: .settings(configurations: [
        .debug(name: "debug", xcconfig: "\(projectName)/configs/project.xcconfig"),
        .release(name: "release", xcconfig: "\(projectName)/configs/project.xcconfig")
    ]),
    targets: [
        .target(
            name: "app",
            destinations: .iOS,
            product: .app,
            bundleId: bundleName,
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                    "UIBackgroundModes": [
                        "remote-notification"
                    ]
                ]
            ),
            sources: ["\(projectName)/sources/app/**"],
            resources: ["\(projectName)/resources/**"],
            dependencies: [
                .package(product: "FirebaseAuth", type: .runtime, condition: nil)
            ],
            settings: .settings(configurations: [
                .debug(name: "debug", xcconfig: "\(projectName)/configs/app.xcconfig"),
                .release(name: "release", xcconfig: "\(projectName)/configs/app.xcconfig"),
            ])
        )
    ]
)
